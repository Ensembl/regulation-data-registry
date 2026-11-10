#!/usr/bin/env sh
set -eu

usage() {
    cat <<'EOF'
Usage: dvc.sh [-e ENGINE] [-h] COMMAND [ARGUMENTS...]

Options (before COMMAND):
  -e ENGINE    Select auto, podman, or docker; overrides CONTAINER_ENGINE.
  -h           Show this help and exit.

Run DVC in this repository's container. The image builds on first use.
Engine selection defaults to CONTAINER_ENGINE, or auto when unset.
Auto prefers Podman, then Docker. Podman requires podman-compose.
Options after COMMAND are passed to DVC unchanged.
Use -- before DVC's global options, such as --version or --help.

Examples:
  ./scripts/dvc.sh status
  ./scripts/dvc.sh -e podman pull
  ./scripts/dvc.sh -e docker push -r ensreg-git-lfs
  ./scripts/dvc.sh -- --version
  ./scripts/dvc.sh -- --help
EOF
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

cd "$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
exec ./scripts/container.sh -e "$engine" dvc-compose run --build --rm --no-deps -T dvc "$@"
