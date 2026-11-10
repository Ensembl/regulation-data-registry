#!/usr/bin/env bash
set -euo pipefail
# The archive includes schema, table data, sequences and restore dependencies.
exec pg_restore --exit-on-error --single-transaction \
    --username="$POSTGRES_USER" --dbname="$POSTGRES_DB" /snapshot/data.dump
