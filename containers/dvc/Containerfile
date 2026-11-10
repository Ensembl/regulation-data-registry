# syntax=docker/dockerfile:1
FROM python:3.12-slim-bookworm AS base

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        git \
        passwd \
        util-linux \
    && rm -rf /var/lib/apt/lists/*

FROM base AS builder
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv
# Precompile dependencies to reduce DVC startup work.
ENV UV_COMPILE_BYTECODE=1
# Copy packages because the BuildKit cache is on a separate filesystem.
ENV UV_LINK_MODE=copy
# Keep the environment outside the checkout mount and copy it into the runtime.
ENV UV_PROJECT_ENVIRONMENT=/opt/dvc
# Use the base image's Python, which is available in both build and runtime stages.
ENV UV_PYTHON_DOWNLOADS=never
WORKDIR /build
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml,readonly \
    --mount=type=bind,source=uv.lock,target=uv.lock,readonly \
    uv sync --locked --no-dev --no-install-project \
    && uv pip check --python /opt/dvc/bin/python

FROM base AS runtime
COPY --from=builder /opt/dvc /opt/dvc
ENV PATH="/opt/dvc/bin:$PATH"

WORKDIR /workspace
COPY --chmod=755 entrypoint.sh /usr/local/bin/dvc-entrypoint
ENTRYPOINT ["dvc-entrypoint"]
