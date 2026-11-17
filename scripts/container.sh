#!/usr/bin/env sh
set -eu

usage() {
    cat <<'EOF'
Usage: container.sh [-h] COMMAND [ARGUMENTS...]

Commands:
  compose      Run the database Docker Compose configuration.
  dvc-compose  Run the DVC Docker Compose configuration.

Arguments after COMMAND are passed to Docker Compose unchanged.
EOF
}

run_db_compose() {
    repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
    cd "$repo_root"

    # Load optional local overrides explicitly.
    if [ -f .env ]; then
        exec docker compose --env-file .env --file containers/compose.yml "$@"
    else
        exec docker compose --env-file /dev/null --file containers/compose.yml "$@"
    fi
}

run_dvc_compose() {
    repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
    cd "$repo_root"

    DVC_UID=$(id -u)
    DVC_GID=$(id -g)
    export DVC_UID DVC_GID

    # Isolate DVC from the database's Compose project and .env file.
    exec docker compose --env-file /dev/null --project-name rdr-dvc \
        --file containers/compose.dvc.yml "$@"
}

case "${1:-}" in
    -h|--help) usage; exit 0 ;;
    compose) shift; run_db_compose "$@" ;;
    dvc-compose) shift; run_dvc_compose "$@" ;;
    *) usage >&2; exit 2 ;;
esac
