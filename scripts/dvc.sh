#!/usr/bin/env sh
set -eu

usage() {
    cat <<'EOF'
Usage: dvc.sh [-h] COMMAND [ARGUMENTS...]

Run DVC using Docker Compose. The image builds on first use.
Arguments after COMMAND are passed to DVC unchanged.
Use -- before DVC's global options, such as --version or --help.

Examples:
  ./scripts/dvc.sh status
  ./scripts/dvc.sh pull
  ./scripts/dvc.sh push -r ensreg-git-lfs
  ./scripts/dvc.sh -- --version
EOF
}

while getopts ':h' option; do
    case "$option" in
        h) usage; exit 0 ;;
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
exec ./scripts/container.sh dvc-compose run --build --rm --no-deps -T dvc "$@"
