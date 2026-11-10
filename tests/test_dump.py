"""Check native archive export and failure preservation without a database."""
import json
import os
from pathlib import Path
import subprocess
import shutil
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ArchiveExport(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.output = self.root / 'db'
        self.output.mkdir()
        (self.output / 'data.dump').write_bytes(b'previous archive')
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
if (name=='pg_dump' and mode=='dump-failure') or ('--list' in args and mode=='list-failure') or ('--schema-only' in args and name=='pg_restore' and mode=='schema-failure'):
    sys.exit(1)
output=next((arg.split('=',1)[1] for arg in args if arg.startswith('--file=')),None)
if output:
    Path(output).write_text('new archive' if name=='pg_dump' else 'new schema')
'''
        for name in ['pg_dump', 'pg_restore']:
            path = self.bin / name
            path.write_text(mock)
            path.chmod(0o755)

    def export(self, target='db-dump', mode='success'):
        compose = self.bin / 'compose'
        compose.write_text("#!/usr/bin/env python3\nimport subprocess,sys\nargs=sys.argv[1:]\nsys.exit(subprocess.run([args[args.index('--entrypoint')+1], *args[args.index('db-dump')+1:]]).returncode)\n")
        compose.chmod(0o755)
        return subprocess.run(['make', '--no-print-directory', '-f', str(ROOT / 'Makefile'),
                               'DB_COMPOSE=' + str(compose), 'DB_DUMP_DIR=' + str(self.output), target],
                              cwd=self.root,
                              env=dict(os.environ, PATH=str(self.bin)+os.pathsep+os.environ['PATH'],
                                       TEST_CALLS=str(self.log), TEST_MODE=mode),
                              text=True, capture_output=True)

    def test_schema_and_archive_come_from_one_dump(self):
        result = self.export()
        self.assertEqual(result.returncode, 0, result.stderr)
        calls = [json.loads(line) for line in self.log.read_text().splitlines()]
        self.assertEqual([call[0] for call in calls], ['pg_dump', 'pg_restore', 'pg_restore'])
        self.assertIn('--format=custom', calls[0])
        self.assertNotIn('--data-only', calls[0])
        self.assertIn('--list', calls[1])
        self.assertIn('--schema-only', calls[2])
        self.assertEqual((self.output/'data.dump').read_text(), 'new archive')
        self.assertEqual((self.output/'schema.sql').read_text(), 'new schema')

    def test_failures_preserve_both_previous_outputs(self):
        for mode in ['dump-failure', 'list-failure', 'schema-failure']:
            with self.subTest(mode=mode):
                result = self.export(mode=mode)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual((self.output/'data.dump').read_bytes(), b'previous archive')
                self.assertEqual((self.output/'schema.sql').read_text(), 'previous schema')
                self.assertEqual(sorted(p.name for p in self.output.iterdir()), ['data.dump','schema.sql'])

    def test_legacy_targets_export_a_matching_pair(self):
        for target in ['db-schema-dump', 'db-data-dump']:
            with self.subTest(target=target):
                result = self.export(target)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual((self.output/'data.dump').read_text(), 'new archive')
                self.assertEqual((self.output/'schema.sql').read_text(), 'new schema')

    def test_failed_install_rolls_back_both_outputs(self):
        move = self.bin / 'mv'
        move.write_text('#!/usr/bin/env python3\nimport subprocess,sys\nsource=sys.argv[1]\n'
                        "if source.endswith('/schema.sql') and '/previous/' not in source: sys.exit(1)\n"
                        'sys.exit(subprocess.run([' + repr(shutil.which('mv')) + ',*sys.argv[1:]]).returncode)\n')
        move.chmod(0o755)
        result = self.export()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual((self.output/'data.dump').read_bytes(), b'previous archive')
        self.assertEqual((self.output/'schema.sql').read_text(), 'previous schema')



if __name__ == '__main__':
    unittest.main()
