#!/usr/bin/env python3
"""Couple local DVC snapshots with their Git commits and publication."""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile

SCHEMA = 'db/schema.sql'
POINTER = 'db/snapshot.dump.dvc'
FILES = [SCHEMA, POINTER]
REMOTE = 'ensreg-git-lfs'


def run(*args, capture=False):
    result = subprocess.run(args, check=True, text=True,
                            stdout=subprocess.PIPE if capture else None)
    return result.stdout.strip() if capture else None


def fail(message):
    raise ValueError(message)


def commit():
    message = os.environ.get('MSG', '')
    if not message.strip():
        fail('Supply a commit message: make db-commit MSG="Describe the snapshot changes"')
    staged = run('git', 'diff', '--cached', '--name-only', '-z', capture=True)
    unrelated = set(filter(None, staged.split('\0'))) - set(FILES)
    if unrelated:
        fail('Unstage unrelated files before db-commit: ' + ', '.join(sorted(unrelated)))
    for name in [SCHEMA, 'db/snapshot.dump']:
        if not Path(name).is_file():
            fail(f'Missing {name}; run make db-dump first.')
    run('make', '--no-print-directory', 'db-validate')
    run('./scripts/dvc.sh', 'add', 'db/snapshot.dump')
    run('git', 'add', '--', *FILES)
    run('git', 'commit', '-m', message, '--', *FILES)


def push():
    branch = run('git', 'symbolic-ref', '--quiet', '--short', 'HEAD', capture=True)
    remote = run('git', 'config', '--get', f'branch.{branch}.remote', capture=True)
    merge = run('git', 'config', '--get', f'branch.{branch}.merge', capture=True)
    if remote == '.' or not merge.startswith('refs/heads/'):
        fail('db-push requires a branch with a remote upstream.')
    # Use the configured upstream explicitly, regardless of push.default.
    run('git', 'rev-parse', '--verify', '@{upstream}', capture=True)
    if run('git', 'status', '--porcelain', '--', *FILES, capture=True):
        fail('Snapshot files have uncommitted changes; run make db-commit first.')
    if json.loads(run('./scripts/dvc.sh', 'status', '--json', POINTER, capture=True)):
        fail('The local archive differs from its DVC pointer; run make db-commit first.')
    revisions = run('git', 'rev-list', '--reverse', '@{upstream}..HEAD', capture=True).splitlines()
    # Include HEAD even when there are no outgoing commits, allowing upload retries.
    revisions.append('HEAD')
    pointers = set()
    for revision in revisions:
        # Earlier revisions may predate the full snapshot format.
        names = run('git', 'ls-tree', '--name-only', revision, '--', POINTER, capture=True)
        if names:
            pointers.add(run('git', 'show', f'{revision}:{POINTER}', capture=True))
    # Temporary pointer outputs have distinct paths, avoiding overlap with the
    # working snapshot. DVC push reads objects from cache, not the output files.
    with tempfile.TemporaryDirectory(prefix='.db-push-', dir='.') as directory:
        for index, content in enumerate(sorted(pointers)):
            folder = Path(directory) / str(index)
            folder.mkdir()
            target = folder / 'snapshot.dump.dvc'
            target.write_text(content + '\n')
            run('./scripts/dvc.sh', 'push', '-r', REMOTE, str(target))
    run('git', 'push', remote, f'HEAD:{merge}')


def main():
    os.chdir(Path(__file__).resolve().parents[1])
    try:
        if sys.argv[1:] == ['commit']:
            commit()
        elif sys.argv[1:] == ['push']:
            push()
        else:
            fail('Usage: db-workflow.py commit|push')
    except (ValueError, subprocess.CalledProcessError) as error:
        print(f'Database workflow stopped: {error}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
