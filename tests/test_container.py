"""Exercise engine selection and argument forwarding without starting containers."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ContainerCommands(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.bin = Path(self.temp.name)
        (self.bin / 'sh').symlink_to('/bin/sh')
        (self.bin / 'cat').symlink_to('/bin/cat')
        for name in ('dirname', 'id'):
            (self.bin / name).symlink_to('/usr/bin/' + name)
        self.env = dict(os.environ, PATH=str(self.bin), CONTAINER_ENGINE='auto')
        self.env.pop('PODMAN_COMPOSE_PROVIDER', None)

    def install(self, name, status=0):
        path = self.bin / name
        path.write_text('#!/bin/sh\nprintf "%s\\n" "$0" "${PODMAN_COMPOSE_PROVIDER:-}" "$@"\nexit ' + str(status) + '\n')
        path.chmod(0o755)

    def run_command(self, *args, engine='auto', script='container.sh'):
        return subprocess.run([str(ROOT / 'scripts' / script), *args],
                              env=dict(self.env, CONTAINER_ENGINE=engine),
                              text=True, capture_output=True)

    def test_prefers_podman_and_sets_provider(self):
        for name in ('podman', 'docker', 'podman-compose'):
            self.install(name)
        result = self.run_command('compose', 'version')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.splitlines()[:2],
                         [str(self.bin / 'podman'), str(self.bin / 'podman-compose')])

    def test_help_does_not_require_an_engine(self):
        result = self.run_command('-h')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('Usage:', result.stdout)
        self.assertIn('dvc-compose', result.stdout)

    def test_option_errors_and_missing_command(self):
        for args in [(), ('-e',), ('-x',)]:
            with self.subTest(args=args):
                result = self.run_command(*args)
                self.assertEqual(result.returncode, 2)
                self.assertIn('Usage:', result.stderr)

    def test_engine_option_overrides_environment(self):
        self.install('docker')
        result = self.run_command('-e', 'docker', 'engine', engine='podman')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.strip(), 'docker')

    def test_command_options_are_forwarded(self):
        self.install('docker')
        result = self.run_command('compose', '-h', engine='docker')
        self.assertEqual(result.stdout.splitlines()[-1], '-h')
        self.assertIn('containers/compose.yml', result.stdout.splitlines())
        result = self.run_command('--', '--version', engine='docker')
        self.assertEqual(result.stdout.splitlines()[2:], ['--version'])

    def test_docker_fallback_and_explicit_override(self):
        self.install('docker')
        self.assertIn(str(self.bin / 'docker'), self.run_command('info').stdout)
        self.install('podman')
        result = self.run_command('compose', 'version', engine='docker')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.splitlines()[0], str(self.bin / 'docker'))

    def test_missing_engine_or_provider_is_actionable(self):
        self.assertIn('Install Podman', self.run_command('info').stderr)
        self.install('podman')
        result = self.run_command('compose', 'version')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Install podman-compose', result.stderr)
        self.assertNotEqual(self.run_command('info', engine='invalid').returncode, 0)

    def test_engine_failure_is_propagated(self):
        self.install('podman', status=42)
        self.install('docker')
        self.assertEqual(self.run_command('info').returncode, 42)

    def test_dvc_overlay_and_quoted_arguments(self):
        for name in ('podman', 'podman-compose', 'docker'):
            self.install(name)
        for engine in ('podman', 'docker'):
            result = self.run_command('status', 'path with spaces', engine=engine, script='dvc.sh')
            self.assertEqual(result.returncode, 0, result.stderr)
            args = result.stdout.splitlines()[2:]
            self.assertEqual(args[-2:], ['status', 'path with spaces'])
            self.assertIn('containers/compose.dvc.yml', args)
            self.assertEqual('containers/compose.dvc.podman.yml' in args, engine == 'podman')
            self.assertEqual('containers/compose.dvc.docker.yml' in args, engine == 'docker')
            self.assertIn('/dev/null', args)

    def test_dvc_help_and_option_errors(self):
        result = self.run_command('-h', script='dvc.sh')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('Usage: dvc.sh', result.stdout)
        for args in [(), ('-e',), ('-x',)]:
            with self.subTest(args=args):
                result = self.run_command(*args, script='dvc.sh')
                self.assertEqual(result.returncode, 2)
                self.assertIn('Usage:', result.stderr)

    def test_dvc_engine_override_and_option_forwarding(self):
        self.install('docker')
        for command in [('status', '-h'), ('--', '--version'), ('--', '--help')]:
            with self.subTest(command=command):
                result = self.run_command('-e', 'docker', *command,
                                          engine='podman', script='dvc.sh')
                self.assertEqual(result.returncode, 0, result.stderr)
                args = result.stdout.splitlines()[2:]
                forwarded = list(command[1:] if command[0] == '--' else command)
                self.assertEqual(args[-len(forwarded):], forwarded)
                self.assertIn('containers/compose.dvc.docker.yml', args)


if __name__ == '__main__':
    unittest.main()
