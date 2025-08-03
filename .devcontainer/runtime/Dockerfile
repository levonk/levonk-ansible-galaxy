# Runtime environment
FROM base as runtime

# Install minimal runtime dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-apt \
    && rm -rf /var/lib/apt/lists/*

# Switch back to non-root user
USER developer

# Set up Python virtual environment
RUN python3 -m venv /home/developer/venv
ENV PATH="/home/developer/venv/bin:$PATH"

# Install only required Python packages using uv
COPY requirements.txt /tmp/requirements.txt
RUN uv pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

# Install Ansible using uv
RUN uv pip install --no-cache-dir ansible

WORKDIR /workspace
