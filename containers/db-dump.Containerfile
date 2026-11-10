ARG POSTGRES_VERSION=14
FROM docker.io/library/postgres:${POSTGRES_VERSION}

RUN apt-get update \
    && apt-get install --no-install-recommends -y coreutils gawk sed \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /dump
COPY --chmod=755 scripts/dump.sh .
ENTRYPOINT ["/dump/dump.sh"]
