#!/usr/bin/env sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root"

SCHEMASPY_UID=$(id -u)
SCHEMASPY_GID=$(id -g)
case "$(./scripts/container.sh engine)" in
    podman) SCHEMASPY_USERNS="keep-id:uid=$SCHEMASPY_UID,gid=$SCHEMASPY_GID" ;;
    docker) SCHEMASPY_USERNS=host ;;
esac
export SCHEMASPY_UID SCHEMASPY_GID SCHEMASPY_USERNS

# Generate from scratch so dropped tables do not leave stale HTML or diagrams.
mkdir -p docs
stage=$(mktemp -d "$repo_root/docs/.schemaspy-XXXXXX")
cleanup() {
    status=$?
    if [ -d "$stage/previous" ] && [ ! -d docs/schemaspy ]; then
        mv "$stage/previous" docs/schemaspy
    fi
    rm -rf "$stage"
    exit "$status"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
mkdir "$stage/output"
SCHEMASPY_OUTPUT_DIR="$stage/output"
export SCHEMASPY_OUTPUT_DIR

./scripts/container.sh compose --project-name "${DB_PROJECT:-rdr}" --profile tools \
    run --rm --no-deps -T schemaspy-docs
test -s "$stage/output/index.html"
test -s "$stage/output/relationships.html"

if [ -d docs/schemaspy ]; then
    mv docs/schemaspy "$stage/previous"
fi
mv "$stage/output" docs/schemaspy
printf 'Schema documentation updated in docs/schemaspy/\n'
