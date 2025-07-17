#!/bin/bash
# Copyright (c) 2025 the person whos account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.

# SYNOPSIS
# Runs Ansible development commands inside a Docker container.
#
# DESCRIPTION
# This script simplifies running Ansible tools like ansible-lint and molecule by executing them within a pre-configured Docker container. It mounts the current directory into the container, ensuring that the tools operate on your local files.
#
# USAGE
# ./ansible-dev.sh "<command>"
#
# EXAMPLE
# ./ansible-dev.sh "ansible-lint ."
# ./ansible-dev.sh "molecule test -s default"

set -e

if [ -z "$1" ]; then
    echo "Error: No command provided."
    echo "Usage: $0 \"<command>\""
    exit 1
fi

IMAGE_NAME="ansible-tools"
COMMAND_TO_RUN="$@"

echo "Running command in Docker: ${COMMAND_TO_RUN}"

docker run --rm -v "$(pwd):/workdir" -w /workdir "${IMAGE_NAME}" -c "${COMMAND_TO_RUN}"
