# Base development environment
FROM debian:bookworm-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    ca-certificates \
    curl \
    git \
    gnupg \
    make \
    openssh-client \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user and set up directories
RUN groupadd --gid 1000 developer \
    && useradd --uid 1000 --gid developer --shell /bin/bash --create-home developer \
    && mkdir -p /workspace /home/developer/.local/bin /mnt/d/p \
    && chown -R developer:developer /workspace /home/developer /mnt/d/p

# Switch to non-root user
USER developer
WORKDIR /workspace

# Install uv (fast Python package installer) as developer user
RUN curl -sSf https://astral.sh/uv/install.sh | sh -s -- -y
ENV PATH="/home/developer/.cargo/bin:${PATH}"

# Set up entrypoint
COPY --chown=developer:developer .devcontainer/scripts/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
