#!/usr/bin/env sh
set -eu

# Match the host user so files written to the checkout keep the correct ownership.
# Create container-local account records for Python's username lookup, allowing
# one image to support different host UIDs/GIDs without rebuilding.
if ! getent group "$DVC_GID" >/dev/null; then
    groupadd --gid "$DVC_GID" dvc
fi
# Look up the host UID in the container's user account database ("passwd").
if ! getent passwd "$DVC_UID" >/dev/null; then
    useradd --key UID_MIN=0 --uid "$DVC_UID" --gid "$DVC_GID" --no-create-home \
        --home-dir /tmp --shell /bin/sh dvc
fi

# Root is needed only for account setup; drop privileges before executing DVC.
exec setpriv --reuid "$DVC_UID" --regid "$DVC_GID" --clear-groups dvc "$@"
