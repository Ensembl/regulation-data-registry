"""Check startup ordering and failure handling without a container runtime."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class DatabaseStartup(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        scripts = self.root / 'scripts'
        scripts.mkdir()
        shutil.copy2(ROOT / 'Makefile', self.root / 'Makefile')
        self.log = self.root / 'calls.jsonl'
        mock = '''#!/usr/bin/env python3
import json, os, sys
from pathlib import Path
args=sys.argv[1:]
with Path(os.environ['TEST_CALLS']).open('a') as log:
    log.write(json.dumps([Path(sys.argv[0]).name, *args])+'\\n')
mode=os.environ.get('TEST_MODE','success')
if args == ['engine']:
    print('docker')
elif Path(sys.argv[0]).name == 'dvc.sh' and mode == 'fetch-failure':
    sys.exit(17)
elif 'up' in args and mode == 'start-failure':
    sys.exit(18)
elif 'exec' in args and 'pg_isready' in args[-1] and mode == 'timeout':
    sys.exit(1)
elif 'port' in args:
    print('2345' if mode == 'bare-port' else '127.0.0.1:2345')
'''
        for name in ['container.sh', 'dvc.sh']:
            path = scripts / name
            path.write_text(mock)
            path.chmod(0o755)

    def start(self, mode):
        return subprocess.run(['make', '--no-print-directory', '-j', '4', 'db-up'], cwd=self.root,
                              env=dict(os.environ, TEST_CALLS=str(self.log),
                                       TEST_MODE=mode, DB_START_TIMEOUT='1'),
                              text=True, capture_output=True)

    def calls(self):
        return [json.loads(line) for line in self.log.read_text().splitlines()]

    def test_fetches_before_starting_and_waits_before_showing_connection(self):
        result = self.start('success')
        self.assertEqual(result.returncode, 0, result.stderr)
        calls = self.calls()
        self.assertEqual(calls[0], ['dvc.sh', 'pull'])
        self.assertIn('up', calls[1])
        self.assertIn('pg_isready', calls[2][-1])
        self.assertIn('port', calls[3])
        self.assertIn('RDR is ready', result.stdout)
        self.assertIn('127.0.0.1:2345', result.stdout)

    def test_fetch_failure_does_not_start_database(self):
        result = self.start('fetch-failure')
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(any('up' in call for call in self.calls()))

    def test_normalizes_podman_port_output(self):
        result = self.start('bare-port')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('Address: 127.0.0.1:2345', result.stdout)

    def test_start_failure_is_reported(self):
        result = self.start('start-failure')
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn('RDR is ready', result.stdout)

    def test_timeout_shows_logs_and_fails(self):
        result = self.start('timeout')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('did not become ready', result.stderr)
        self.assertIn('logs', self.calls()[-1])
        self.assertNotIn('RDR is ready', result.stdout)


if __name__ == '__main__':
    unittest.main()
