#!/bin/bash
set -e

# Set up user and permissions
if [ "$(id -u)" = '0' ]; then
    # Update UID/GID if provided
    if [ -n "$USER_UID" ] && [ "$USER_UID" != "$(id -u developer)" ]; then
        usermod -u "$USER_UID" developer
    fi
    if [ -n "$USER_GID" ] && [ "$USER_GID" != "$(id -g developer)" ]; then
        groupmod -g "$USER_GID" developer
        find /home/developer -group "$(id -gn developer)" -exec chgrp developer {} \;
    fi

    # Fix permissions on mounted volumes
    chown -R developer:developer /workspace
    chown -R developer:developer /home/developer

    # Execute command as developer user
    exec gosu developer "$@"
else
    # Already running as non-root user
    exec "$@"
fi
