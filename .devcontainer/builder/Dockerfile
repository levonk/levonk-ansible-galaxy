# Build environment
FROM base as builder

# Install build dependencies and development tools
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    make \
    docker.io \
    docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Add developer to docker group to allow docker commands without sudo
RUN groupadd -g 998 docker \
    && usermod -aG docker developer

# Switch back to non-root user
USER developer

# Set up Python virtual environment
RUN python3 -m venv /home/developer/venv
ENV PATH="/home/developer/venv/bin:$PATH"

# Install Python dependencies using uv
COPY requirements-dev.txt /tmp/requirements-dev.txt
RUN uv pip install --no-cache-dir -r /tmp/requirements-dev.txt && \
    rm /tmp/requirements-dev.txt

# Install Ansible and development tools using uv
RUN uv pip install --no-cache-dir \
    ansible \
    ansible-lint \
    molecule \
    molecule-plugins \
    yamllint \
    flake8 \
    black \
    isort \
    mypy \
    pre-commit \
    pytest \
    pytest-cov \
    pytest-mock \
    markdownlint-cli \
    markdown-link-check

WORKDIR /workspace
