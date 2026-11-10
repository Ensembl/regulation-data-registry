ARG POSTGRES_VERSION

FROM docker.io/library/postgres:${POSTGRES_VERSION}

ARG DB_NAME
ARG POSTGRES_PASSWORD
ARG POSTGRES_USER
ARG PGDATA

ENV POSTGRES_DB ${DB_NAME}
ENV POSTGRES_PASSWORD ${POSTGRES_PASSWORD}
ENV POSTGRES_USER ${POSTGRES_USER}

FROM docker.io/library/postgres:${POSTGRES_VERSION}

RUN apt-get update && apt-get install -y coreutils gawk sed

WORKDIR /dump

COPY scripts/dump.sh .

RUN chmod +x /dump/dump.sh

ENTRYPOINT ["/dump/dump.sh"]

