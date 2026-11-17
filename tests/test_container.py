"""Check Compose configuration, environment isolation, and argument forwarding."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ContainerCommands(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        shutil.copytree(ROOT / 'scripts', self.root / 'scripts')
        self.bin = self.root / 'bin'
        self.bin.mkdir()
        docker = self.bin / 'docker'
        docker.write_text('''#!/bin/sh
printf '%s\\n' "$DOCKER_CONTEXT" "${DVC_UID:-}" "${DVC_GID:-}" "$@"
exit "${TEST_EXIT:-0}"
''')
        docker.chmod(0o755)
        self.env = dict(os.environ, PATH=str(self.bin) + os.pathsep + os.environ['PATH'],
                        DOCKER_CONTEXT='user-selected-context')

    def run_command(self, *args, script='container.sh'):
        return subprocess.run([str(self.root / 'scripts' / script), *args],
                              cwd=self.temp.name, env=self.env,
                              text=True, capture_output=True)

    def test_database_env_file_is_explicit(self):
        for exists in (False, True):
            with self.subTest(env_file=exists):
                if exists:
                    (self.root / '.env').write_text('DB_NAME=custom\n')
                result = self.run_command('compose', '-p', 'custom', 'up', '-d')
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stdout.splitlines()[3:], [
                    'compose', '--env-file', '.env' if exists else '/dev/null',
                    '--file', 'containers/compose.yml', '-p', 'custom', 'up', '-d'])
                self.assertEqual(result.stdout.splitlines()[0], 'user-selected-context')

    def test_dvc_isolates_project_and_passes_host_user_and_arguments(self):
        (self.root / '.env').write_text('DB_NAME=custom\n')
        result = self.run_command('status', 'path with spaces', script='dvc.sh')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.splitlines()[:3],
                         ['user-selected-context', str(os.getuid()), str(os.getgid())])
        self.assertEqual(result.stdout.splitlines()[3:], [
            'compose', '--env-file', '/dev/null', '--project-name', 'rdr-dvc',
            '--file', 'containers/compose.dvc.yml', 'run', '--build', '--rm',
            '--no-deps', '-T', 'dvc', 'status', 'path with spaces'])

    def test_help_and_invalid_usage(self):
        for script in ('container.sh', 'dvc.sh'):
            with self.subTest(script=script):
                self.assertEqual(self.run_command('-h', script=script).returncode, 0)
                for args in ((), ('-x',)):
                    result = self.run_command(*args, script=script)
                    self.assertEqual(result.returncode, 2)
                    self.assertIn('Usage:', result.stderr)

    def test_dvc_global_options_and_compose_options_are_forwarded(self):
        for args in (('--', '--version'), ('--', '--help'), ('status', '-h')):
            result = self.run_command(*args, script='dvc.sh')
            expected = list(args[1:] if args[0] == '--' else args)
            self.assertEqual(result.stdout.splitlines()[-len(expected):], expected)
        result = self.run_command('compose', '-h')
        self.assertEqual(result.stdout.splitlines()[-1], '-h')

    def test_docker_failure_is_propagated(self):
        self.env['TEST_EXIT'] = '42'
        self.assertEqual(self.run_command('compose', 'up').returncode, 42)
        self.assertEqual(self.run_command('pull', script='dvc.sh').returncode, 42)


if __name__ == '__main__':
    unittest.main()
