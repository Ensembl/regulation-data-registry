#!/usr/bin/env sh
set -eu

cd "$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
export DVC_UID="$(id -u)"
export DVC_GID="$(id -g)"

# Use a separate project and ignore the database's .env file.
exec docker compose --env-file /dev/null --project-name rdr-dvc \
    --file compose.dvc.yml run --build --rm --no-deps -T dvc "$@"
