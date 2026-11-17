"""Check archive and review schema export and failure preservation without a database."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class SQLExport(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.output = self.root / 'db'
        self.output.mkdir()
        (self.output / 'snapshot.dump').write_bytes(b'previous data')
        (self.output / 'schema.sql').write_text('previous schema')
        self.log = self.root / 'calls'
        self.bin = self.root / 'bin'
        self.bin.mkdir()
        mock = '''#!/usr/bin/env python3
import json, os, sys
from pathlib import Path
name=Path(sys.argv[0]).name
args=sys.argv[1:]
with open(os.environ['TEST_CALLS'],'a') as log:
    log.write(json.dumps([name,*args])+'\\n')
mode=os.environ.get('TEST_MODE','success')
if name=='psql':
    sys.exit(0)
if name=='pg_dump' and mode=='dump-failure': sys.exit(1)
if '--schema-only' in args and mode=='schema-failure':
    sys.exit(1)
output=next((arg.split('=',1)[1] for arg in args if arg.startswith('--file=')),None)
if output:
    Path(output).write_text('new archive' if name=='pg_dump' else 'new schema')
'''
        for name in ['pg_dump', 'pg_restore', 'psql']:
            path = self.bin / name
            path.write_text(mock)
            path.chmod(0o755)

    def export(self, mode='success'):
        compose = self.bin / 'compose'
        compose.write_text("#!/usr/bin/env python3\nimport subprocess,sys\nargs=sys.argv[1:]\nsys.exit(subprocess.run([args[args.index('--entrypoint')+1], *args[args.index('db-dump')+1:]]).returncode)\n")
        compose.chmod(0o755)
        return subprocess.run(['make', '--no-print-directory', '-f', str(ROOT / 'Makefile'),
                               'DB_COMPOSE=' + str(compose), 'DB_DUMP_DIR=' + str(self.output), 'db-dump'],
                              cwd=self.root,
                              env=dict(os.environ, PATH=str(self.bin)+os.pathsep+os.environ['PATH'],
                                       TEST_CALLS=str(self.log), TEST_MODE=mode),
                              text=True, capture_output=True, timeout=15)

    def test_schema_comes_from_retained_archive(self):
        result = self.export()
        self.assertEqual(result.returncode, 0, result.stderr)
        calls = [json.loads(line) for line in self.log.read_text().splitlines()]
        self.assertEqual([call[0] for call in calls], ['pg_dump', 'pg_restore'])
        self.assertIn('--format=custom', calls[0])
        self.assertIn('--schema-only', calls[1])
        archive = next(arg.split('=', 1)[1] for arg in calls[0] if arg.startswith('--file='))
        self.assertEqual(calls[1][-1], archive)
        self.assertEqual(sorted(p.name for p in self.output.iterdir()), ['schema.sql', 'snapshot.dump'])
        self.assertEqual((self.output/'snapshot.dump').read_text(), 'new archive')
        self.assertEqual((self.output/'schema.sql').read_text(), 'new schema')

    def test_failures_preserve_both_previous_outputs(self):
        for mode in ['dump-failure', 'schema-failure']:
            with self.subTest(mode=mode):
                result = self.export(mode=mode)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual((self.output/'snapshot.dump').read_bytes(), b'previous data')
                self.assertEqual((self.output/'schema.sql').read_text(), 'previous schema')
                self.assertEqual(sorted(p.name for p in self.output.iterdir()), ['schema.sql','snapshot.dump'])

    def test_initialization_restores_full_archive_in_one_transaction(self):
        result = subprocess.run(['bash', str(ROOT/'containers/init-db.sh')],
                                env=dict(os.environ, PATH=str(self.bin)+os.pathsep+os.environ['PATH'],
                                         TEST_CALLS=str(self.log), POSTGRES_USER='test', POSTGRES_DB='test'),
                                input='', text=True, capture_output=True, timeout=10)
        self.assertEqual(result.returncode, 0, result.stderr)
        call = json.loads(self.log.read_text())
        self.assertIn('--single-transaction', call)
        self.assertEqual(call[0], 'pg_restore')
        self.assertIn('--exit-on-error', call)
        self.assertEqual(call[-1], '/snapshot/snapshot.dump')


if __name__ == '__main__':
    unittest.main()
