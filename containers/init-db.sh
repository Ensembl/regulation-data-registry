#!/usr/bin/env bash
set -euo pipefail
# Restore the full archive in dependency order, including constraints after data.
exec pg_restore --exit-on-error --single-transaction \
    --username="$POSTGRES_USER" --dbname="$POSTGRES_DB" \
    /snapshot/snapshot.dump
