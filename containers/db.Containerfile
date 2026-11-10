ARG POSTGRES_VERSION=14
FROM docker.io/library/postgres:${POSTGRES_VERSION}

# Load the selected schema and DVC-managed data at container startup.
COPY db/*.sql /docker-entrypoint-initdb.d/
