# Copyright (c) 2025 the person whos account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.

# This Dockerfile creates a development environment for Ansible projects.
# It includes ansible, ansible-lint, molecule, and other useful tools.
FROM python:3.11-slim

LABEL org.opencontainers.image.title="levonk/ansible-dev" \
      org.opencontainers.image.description="Ansible development environment with linting and testing tools." \
      org.opencontainers.image.licenses="AGPL-3.0"

# Install essential Ansible development tools
RUN pip install --no-cache-dir \
    ansible \
    ansible-lint \
    molecule[docker] \
    yamllint \
    testinfra

# Set the working directory inside the container
WORKDIR /workdir

# Set the entrypoint to bash to allow for interactive sessions
ENTRYPOINT ["bash"]
