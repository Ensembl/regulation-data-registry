#!/usr/bin/env bash
set -euo pipefail

docker-entrypoint.sh postgres &
server=$!
cleanup() {
    kill -TERM "$server" 2>/dev/null || true
    wait "$server" 2>/dev/null || true
}
trap cleanup EXIT

for ((attempt=0; attempt<120; attempt++)); do
    if ! kill -0 "$server" 2>/dev/null; then
        echo 'Snapshot restore failed.' >&2
        exit 1
    fi
    if pg_isready -h 127.0.0.1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" >/dev/null 2>&1; then
        psql -X -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" \
            -c "SELECT count(*) AS tables FROM pg_tables WHERE schemaname = 'public';"
        echo 'Snapshot restored successfully.'
        exit 0
    fi
    sleep 1
done
echo 'Snapshot restore timed out.' >&2
exit 1
