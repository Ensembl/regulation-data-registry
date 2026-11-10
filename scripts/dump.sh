#!/usr/bin/env bash
# See the NOTICE file distributed with this work for additional information
# regarding copyright ownership.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

# === Default values ===
DB_NAME="${DB_NAME:-rdr}"
POSTGRES_USER="${POSTGRES_USER:-regulation_usr}"
POSTGRES_HOST="${POSTGRES_HOST:-db}"
POSTGRES_PORT="${POSTGRES_PORT:-5432}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-rdr-local-password}"
OUTPUT_DIR="/db"

DUMP_SCHEMA=false
DUMP_DATA=false

# === Help ===
usage() {
  cat <<EOF
📦 RDR PostgreSQL Dump Utility

Usage:
  ./dump.sh [options]

Options:
  -s, --schema         Dump schema only
  -d, --data           Dump data only
  -h, --help           Show this help message

Defaults:
  If no options are given, both schema and data will be dumped.

Environment Variables:
  DB_NAME             Database name (default: rdr)
  POSTGRES_USER       Database user (default: regulation_usr)
  POSTGRES_PASSWORD   Password for DB user (default: rdr-local-password)
  POSTGRES_HOST       Hostname of the DB (default: db)
  POSTGRES_PORT       Port number (default: 5432)

Example:
  ./scripts/container.sh compose run --rm db-dump --schema
  ./scripts/container.sh compose run --rm db-dump --data
  ./scripts/container.sh compose run --rm db-dump         # dumps both
EOF
}

# === Argument parsing with getopt ===
OPTS=$(getopt -o sdh --long schema,data,help -n 'dump.sh' -- "$@")
if [ $? != 0 ]; then
  usage
  exit 1
fi

eval set -- "$OPTS"

# If no flags are passed, dump everything
if [ $# -eq 1 ]; then
  DUMP_SCHEMA=true
  DUMP_DATA=true
fi

while true; do
  case "$1" in
    -s | --schema ) DUMP_SCHEMA=true; shift ;;
    -d | --data ) DUMP_DATA=true; shift ;;
    -h | --help ) usage; exit 0 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

# === Setup ===
mkdir -p "$OUTPUT_DIR"
# Complete the export before replacing the previous snapshot.
DUMP_DIR=$(mktemp -d)
trap 'rm -rf "$DUMP_DIR"' EXIT
export PGPASSWORD="$POSTGRES_PASSWORD"

# === Schema Dump ===
if [ "$DUMP_SCHEMA" = true ]; then

  LICENSE_HEADER="-- See the NOTICE file distributed with this work for additional information
  -- regarding copyright ownership.
  --
  -- Licensed under the Apache License, Version 2.0 (the \"License\");
  -- you may not use this file except in compliance with the License.
  -- You may obtain a copy of the License at
  -- http://www.apache.org/licenses/LICENSE-2.0
  --
  -- Unless required by applicable law or agreed to in writing, software
  -- distributed under the License is distributed on an \"AS IS\" BASIS,
  -- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  -- See the License for the specific language governing permissions and
  -- limitations under the License."


  echo "📜 Dumping schema..."

  SCHEMA_FILE="$DUMP_DIR/000_schema.sql"
  TMP_FILE="${SCHEMA_FILE}.tmp"
  pg_dump \
    --host="$POSTGRES_HOST" \
    --port="$POSTGRES_PORT" \
    --username="$POSTGRES_USER" \
    --dbname="$DB_NAME" \
    --schema-only \
    > "$TMP_FILE"

  {
    echo "$LICENSE_HEADER"
    echo ""
    cat "$TMP_FILE"
  } > "$SCHEMA_FILE"

  rm "$TMP_FILE"

  echo "🟢 Schema dumped to 000_schema.sql"
fi

# === Data Dump ===
if [ "$DUMP_DATA" = true ]; then
  echo "🗃️  Dumping table data individually (order matters here).."
  count=1

  TABLE_ORDER=$(pg_dump \
    --data-only \
    --dbname="$DB_NAME" \
    --host="$POSTGRES_HOST" \
    --port="$POSTGRES_PORT" \
    --username="$POSTGRES_USER" \
  | grep '^-- Data for Name:' \
  | sed -E 's/^-- Data for Name: ([^;]+);.*$/\1/')

  count=1
  for table in $TABLE_ORDER; do
    prefix=$(printf "%03d" "$count")
    filename="${prefix}_public_${table}.sql"
    echo "☑️ Dumping public.$table → $filename"
    pg_dump \
      --host="$POSTGRES_HOST" \
      --port="$POSTGRES_PORT" \
      --username="$POSTGRES_USER" \
      --dbname="$DB_NAME" \
      --data-only \
      --table="public.${table}" \
      --file="$DUMP_DIR/$filename"
    ((count++))
  done

  echo "🟢 Data dump complete into $DUMP_DIR/"
fi

# Remove old numbered dumps, including files whose order changed or tables that
# were deleted. DVC pointers are left for the contributor to review and update.
if [ "$DUMP_DATA" = true ]; then
  rm -f "$OUTPUT_DIR"/[0-9][0-9][0-9]_public_*.sql
fi
mv "$DUMP_DIR"/*.sql "$OUTPUT_DIR/"
echo "Snapshot exported to $OUTPUT_DIR"
