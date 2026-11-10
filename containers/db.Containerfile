ARG POSTGRES_VERSION

FROM docker.io/library/postgres:${POSTGRES_VERSION} AS base

ARG DB_NAME
ARG POSTGRES_PASSWORD
ARG POSTGRES_USER
ARG PGDATA

ENV POSTGRES_DB=${DB_NAME}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV PGDATA=${PGDATA}


FROM base AS init-data

COPY db/* /docker-entrypoint-initdb.d/

# Remove exec "$@" content from docker-entrypoint.sh
# to avoid starting PostgreSQL daemon
RUN ["sed", "-i", \
    "s/exec \"$@\"/echo \"skipping...\"/", \
    "/usr/local/bin/docker-entrypoint.sh"]

RUN ["/usr/local/bin/docker-entrypoint.sh", "postgres"]

FROM base

COPY --from=init-data ${PGDATA} ${PGDATA}
