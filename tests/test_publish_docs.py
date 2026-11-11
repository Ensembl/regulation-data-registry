"""Check local documentation publishing without changing the working branch."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class DocumentationPublishing(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / 'scripts').mkdir()
        shutil.copy2(ROOT / 'scripts/publish-docs.sh',
                     self.root / 'scripts/publish-docs.sh')
        self.git('init', '--quiet', '--initial-branch=main')
        self.git('config', 'user.name', 'Documentation test')
        self.git('config', 'user.email', 'docs@example.invalid')
        self.git('config', 'commit.gpgsign', 'false')
        (self.root / 'README.md').write_text('main branch')
        self.git('add', 'README.md')
        self.git('commit', '--quiet', '-m', 'Initial source')
        self.main = self.git('rev-parse', 'HEAD')
        self.docs = self.root / 'docs/schemaspy'
        self.docs.mkdir(parents=True)
        for name in ('index.html', 'relationships.html', 'obsolete.html'):
            (self.docs / name).write_text(name)

    def git(self, *args):
        return subprocess.check_output(['git', *args], cwd=self.root,
                                       text=True).strip()

    def publish(self):
        return subprocess.run(['./scripts/publish-docs.sh'], cwd=self.root,
                              text=True, capture_output=True)

    def test_publishes_only_site_files_and_preserves_checkout_and_index(self):
        (self.root / 'README.md').write_text('staged source change')
        self.git('add', 'README.md')
        staged = self.git('write-tree')
        result = self.publish()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.git('branch', '--show-current'), 'main')
        self.assertEqual(self.git('rev-parse', 'HEAD'), self.main)
        self.assertEqual(self.git('write-tree'), staged)
        self.assertEqual((self.root / 'README.md').read_text(), 'staged source change')
        files = self.git('ls-tree', '-r', '--name-only', 'gh-pages').splitlines()
        self.assertEqual(files, ['.nojekyll', 'index.html', 'obsolete.html',
                                 'relationships.html'])
        published = self.git('rev-parse', 'gh-pages')
        self.assertEqual(self.publish().returncode, 0)
        self.assertEqual(self.git('rev-parse', 'gh-pages'), published)

    def test_update_preserves_history_and_removes_obsolete_pages(self):
        self.assertEqual(self.publish().returncode, 0)
        previous = self.git('rev-parse', 'gh-pages')
        (self.docs / 'obsolete.html').unlink()
        (self.docs / 'index.html').write_text('updated schema')
        result = self.publish()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.git('rev-parse', 'gh-pages^'), previous)
        self.assertEqual(self.git('show', 'gh-pages:index.html'), 'updated schema')
        self.assertNotIn('obsolete.html', self.git('ls-tree', '-r', '--name-only',
                                                 'gh-pages').splitlines())

    def test_incomplete_output_preserves_existing_branch(self):
        self.assertEqual(self.publish().returncode, 0)
        previous = self.git('rev-parse', 'gh-pages')
        (self.docs / 'relationships.html').unlink()
        result = self.publish()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('make schemaspy-docs', result.stderr)
        self.assertEqual(self.git('rev-parse', 'gh-pages'), previous)


if __name__ == '__main__':
    unittest.main()
