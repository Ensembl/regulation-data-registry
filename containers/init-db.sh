#!/usr/bin/env bash
set -euo pipefail
# Keep SQL outside the automatic init directory so it is executed exactly once.
exec psql -X --set=ON_ERROR_STOP=1 --single-transaction \
    --username="$POSTGRES_USER" --dbname="$POSTGRES_DB" \
    --file=/snapshot/schema.sql --file=/snapshot/data.sql
