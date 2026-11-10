ARG POSTGRES_VERSION=14
FROM docker.io/library/postgres:${POSTGRES_VERSION}

COPY db/data.dump /snapshot/data.dump
COPY --chmod=755 containers/init-db.sh /docker-entrypoint-initdb.d/010-restore.sh
COPY --chmod=755 containers/validate-db.sh /usr/local/bin/validate-db
