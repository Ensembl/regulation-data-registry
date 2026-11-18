"""Exercise coupled publication without making commits or contacting remotes."""
import importlib.util
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('db_workflow', ROOT/'scripts/db-workflow.py')
workflow = importlib.util.module_from_spec(spec)
spec.loader.exec_module(workflow)


class CoupledWorkflow(unittest.TestCase):
    def setUp(self):
        self.calls = []

    def fake_run(self, *args, capture=False):
        self.calls.append(args)
        answers = {
            ('git', 'symbolic-ref', '--quiet', '--short', 'HEAD'): 'main',
            ('git', 'config', '--get', 'branch.main.remote'): 'origin',
            ('git', 'config', '--get', 'branch.main.merge'): 'refs/heads/main',
            ('./scripts/dvc.sh', 'status', '--json', workflow.POINTER): '{}',
            ('git', 'rev-list', '--reverse', '@{upstream}..HEAD'): 'first\nsecond',
        }
        if args[:2] == ('git', 'ls-tree'):
            return workflow.POINTER
        if args[:2] == ('git', 'show'):
            return 'first snapshot' if args[2].startswith('first:') else 'second snapshot'
        if args[:2] == ('./scripts/dvc.sh', 'push'):
            self.uploads.append(Path(args[-1]).read_text())
        return answers.get(args, '' if capture else None)

    def test_make_passes_message_literally_through_environment(self):
        import json
        import sys
        with tempfile.TemporaryDirectory() as directory:
            folder = Path(directory)
            executable = folder/'python3'
            executable.write_text('#!' + sys.executable + '\nimport json, os\nprint(json.dumps(os.environ["MSG"]))\n')
            executable.chmod(0o755)
            message = 'Update "rows"; $' + '(touch /tmp/not-executed) `literal`'
            result = subprocess.run(
                ['make', '--no-print-directory', '-s', '-f', str(ROOT/'Makefile'),
                 'db-commit', 'MSG=' + message], cwd=folder,
                env=dict(os.environ, PATH=str(folder)+os.pathsep+os.environ['PATH']),
                capture_output=True, text=True, check=True)
            self.assertEqual(json.loads(result.stdout), message)

    def test_missing_message_stops_before_validation_or_mutations(self):
        with patch.dict(os.environ, MSG=' '), patch.object(workflow, 'run') as run:
            with self.assertRaisesRegex(ValueError, 'commit message'):
                workflow.commit()
            run.assert_not_called()

    def test_unrelated_staging_is_rejected(self):
        with patch.dict(os.environ, MSG='update'), patch.object(workflow, 'run', return_value='other.py\0'):
            with self.assertRaisesRegex(ValueError, 'Unstage unrelated'):
                workflow.commit()

    def test_commit_validates_then_tracks_then_commits_literal_message(self):
        message = 'Update "data"; $(touch /tmp/should-not-exist)'
        with patch.dict(os.environ, MSG=message), patch.object(Path, 'is_file', return_value=True), patch.object(workflow, 'run', side_effect=self.fake_run):
            workflow.commit()
        self.assertEqual(self.calls[1:], [
            ('make', '--no-print-directory', 'db-validate'),
            ('./scripts/dvc.sh', 'add', 'db/snapshot.dump'),
            ('git', 'add', '--', *workflow.FILES),
            ('git', 'commit', '-m', message, '--', *workflow.FILES),
        ])

    def test_failed_validation_does_not_track_or_commit(self):
        def fail_validation(*args, **kwargs):
            if args[0] == 'make':
                raise subprocess.CalledProcessError(1, args)
            return self.fake_run(*args, **kwargs)
        with patch.dict(os.environ, MSG='update'), patch.object(Path, 'is_file', return_value=True), patch.object(workflow, 'run', side_effect=fail_validation):
            with self.assertRaises(subprocess.CalledProcessError):
                workflow.commit()
        self.assertFalse(any(call[0] == './scripts/dvc.sh' for call in self.calls))

    def test_push_uploads_every_outgoing_snapshot_before_git(self):
        self.uploads = []
        with patch.object(workflow, 'run', side_effect=self.fake_run):
            workflow.push()
        self.assertEqual(sorted(self.uploads), ['first snapshot\n', 'second snapshot\n'])
        self.assertEqual(self.calls[-1], ('git', 'push', 'origin', 'HEAD:refs/heads/main'))
        for call in self.calls:
            if call[:2] == ('./scripts/dvc.sh', 'push'):
                self.assertFalse(Path(call[-1]).exists())

    def test_upload_failure_prevents_git_push(self):
        self.uploads = []
        def fail_upload(*args, **kwargs):
            if args[:2] == ('./scripts/dvc.sh', 'push'):
                raise subprocess.CalledProcessError(1, args)
            return self.fake_run(*args, **kwargs)
        with patch.object(workflow, 'run', side_effect=fail_upload):
            with self.assertRaises(subprocess.CalledProcessError):
                workflow.push()
        self.assertNotIn(('git', 'push', 'origin', 'HEAD:refs/heads/main'), self.calls)

    def test_dirty_pointer_or_archive_prevents_upload(self):
        for dirty in ['pointer', 'archive']:
            with self.subTest(dirty=dirty):
                def dirty_run(*args, **kwargs):
                    if args[:2] == ('git', 'status') and dirty == 'pointer':
                        return ' M db/snapshot.dump.dvc'
                    if args[:2] == ('./scripts/dvc.sh', 'status') and dirty == 'archive':
                        return '{"db/snapshot.dump.dvc": [{"changed outs": {"db/snapshot.dump": "modified"}}]}'
                    return self.fake_run(*args, **kwargs)
                self.calls = []
                with patch.object(workflow, 'run', side_effect=dirty_run):
                    with self.assertRaisesRegex(ValueError, 'db-commit'):
                        workflow.push()
                self.assertFalse(any(call[:2] == ('./scripts/dvc.sh', 'push') for call in self.calls))


if __name__ == '__main__':
    unittest.main()
