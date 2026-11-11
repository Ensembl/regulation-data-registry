"""Check documentation replacement and recovery without a container runtime."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class SchemaDocumentation(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / 'scripts').mkdir()
        shutil.copy2(ROOT / 'scripts/schemaspy.sh', self.root / 'scripts/schemaspy.sh')
        self.docs = self.root / 'docs/schemaspy'
        self.docs.mkdir(parents=True)
        (self.docs / 'stale.html').write_text('previous documentation')
        mock = self.root / 'scripts/container.sh'
        mock.write_text('''#!/bin/sh
set -eu
if [ "$1" = engine ]; then echo docker; exit; fi
printf 'new documentation' > "$SCHEMASPY_OUTPUT_DIR/index.html"
case "$TEST_MODE" in
    fail) exit 42 ;;
    incomplete) exit 0 ;;
esac
printf 'relationships' > "$SCHEMASPY_OUTPUT_DIR/relationships.html"
''')
        mock.chmod(0o755)

    def generate(self, mode):
        return subprocess.run(['./scripts/schemaspy.sh'], cwd=self.root,
                              env=dict(os.environ, TEST_MODE=mode),
                              text=True, capture_output=True)

    def test_success_replaces_docs_and_removes_stale_pages(self):
        result = self.generate('success')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse((self.docs / 'stale.html').exists())
        self.assertEqual((self.docs / 'index.html').read_text(), 'new documentation')
        self.assertFalse(list((self.root / 'docs').glob('.schemaspy-*')))

    def test_failed_or_incomplete_generation_preserves_previous_docs(self):
        for mode in ('fail', 'incomplete'):
            with self.subTest(mode=mode):
                result = self.generate(mode)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual((self.docs / 'stale.html').read_text(),
                                 'previous documentation')
                self.assertFalse((self.docs / 'index.html').exists())
                self.assertFalse(list((self.root / 'docs').glob('.schemaspy-*')))


if __name__ == '__main__':
    unittest.main()
