#!/usr/bin/env sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root"

if [ ! -s docs/schemaspy/index.html ] || [ ! -s docs/schemaspy/relationships.html ]; then
    printf 'Generate documentation with make schemaspy-docs first.\n' >&2
    exit 1
fi

# A temporary repository keeps the current checkout and index untouched.
stage=$(mktemp -d "${TMPDIR:-/tmp}/rdr-pages-XXXXXX")
trap 'rm -rf "$stage"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
git init --quiet --initial-branch=gh-pages "$stage"
git -C "$stage" config user.name "$(git config user.name)"
git -C "$stage" config user.email "$(git config user.email)"

if git show-ref --verify --quiet refs/heads/gh-pages; then
    git -C "$stage" fetch --quiet "$repo_root" gh-pages
    git -C "$stage" reset --quiet --hard FETCH_HEAD
    git -C "$stage" rm --quiet -r --ignore-unmatch .
fi

cp -R docs/schemaspy/. "$stage/"
touch "$stage/.nojekyll"
git -C "$stage" add --all
if git -C "$stage" rev-parse --verify HEAD >/dev/null 2>&1 && \
        git -C "$stage" diff --cached --quiet; then
    printf 'The local gh-pages branch is already up to date.\n'
    exit 0
fi

git -C "$stage" commit --quiet -m 'Update schema documentation'
# Fast-forward only: concurrent branch changes are never overwritten.
git fetch --quiet "$stage" gh-pages:gh-pages
printf 'Updated local gh-pages branch. Publish with: git push origin gh-pages\n'
