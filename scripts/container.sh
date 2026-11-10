#!/usr/bin/env sh
set -eu

usage() {
    cat <<'EOF'
Usage: container.sh [-e ENGINE] [-h] COMMAND [ARGUMENTS...]

Options (before COMMAND):
  -e ENGINE    Select auto, podman, or docker; overrides CONTAINER_ENGINE.
  -h           Show this help and exit.

Commands:
  engine       Print the selected engine.
  compose      Run this repository's database Compose configuration.
  dvc-compose  Run Compose with this repository's DVC configuration.
  COMMAND      Forward any other command to the selected engine.

Engine selection defaults to CONTAINER_ENGINE, or auto when unset.
Auto prefers Podman, then Docker. Podman requires podman-compose for Compose.
Options after COMMAND are passed through unchanged. Use -- to end wrapper options.

Examples:
  ./scripts/container.sh -e podman compose up -d db
  ./scripts/container.sh -e docker dvc-compose build --pull --no-cache dvc
  ./scripts/container.sh engine
  ./scripts/container.sh -- --version
EOF
}

fail() {
    printf '%s\n' "$*" >&2
    exit 1
}

select_engine() {
    case "$engine" in
        auto)
            if command -v podman >/dev/null 2>&1; then
                engine=podman
            elif command -v docker >/dev/null 2>&1; then
                engine=docker
            else
                fail 'Install Podman and podman-compose, or Docker with Compose v2.'
            fi
            ;;
        podman|docker)
            if ! command -v "$engine" >/dev/null 2>&1; then
                fail "$engine is not installed."
            fi
            ;;
        *)
            fail 'Engine must be auto, podman, or docker.'
            ;;
    esac
}

run_compose() {
    if [ "$engine" = podman ]; then
        if ! command -v podman-compose >/dev/null 2>&1; then
            fail 'Install podman-compose to use Podman with this repository.'
        fi

        # Podman otherwise prefers docker-compose when both providers are installed.
        PODMAN_COMPOSE_PROVIDER=$(command -v podman-compose)
        export PODMAN_COMPOSE_PROVIDER
    fi

    exec "$engine" compose "$@"
}

run_db_compose() {
    repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
    cd "$repo_root"

    run_compose --file containers/compose.yml "$@"
}

run_dvc_compose() {
    repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
    cd "$repo_root"

    DVC_UID=$(id -u)
    DVC_GID=$(id -g)
    export DVC_UID DVC_GID

    # Isolate DVC from the database's Compose project and .env file.
    run_compose --env-file /dev/null --project-name rdr-dvc \
        --file containers/compose.dvc.yml --file "containers/compose.dvc.$engine.yml" "$@"
}

engine=${CONTAINER_ENGINE:-auto}
while getopts ':he:' option; do
    case "$option" in
        h) usage; exit 0 ;;
        e) engine=$OPTARG ;;
        :) printf 'Option -%s requires an argument.\n' "$OPTARG" >&2
           usage >&2; exit 2 ;;
        \?) printf 'Unknown option: -%s\n' "$OPTARG" >&2
            usage >&2; exit 2 ;;
    esac
done
shift "$((OPTIND - 1))"

if [ "$#" -eq 0 ]; then
    usage >&2
    exit 2
fi

select_engine

case "$1" in
    engine)
        printf '%s\n' "$engine"
        ;;
    compose)
        shift
        run_db_compose "$@"
        ;;
    dvc-compose)
        shift
        run_dvc_compose "$@"
        ;;
    *)
        # Forward ordinary commands such as pull, build, and info unchanged.
        exec "$engine" "$@"
        ;;
esac
