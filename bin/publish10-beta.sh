#!/bin/bash
# publish10-beta.sh - Publish collections to beta server
# Wrapper script for publish-collection.sh with beta server configuration

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configuration
BETA_SERVER="https://galaxy-dev.ansible.com"

# Call the main publish script with beta server configuration
"${SCRIPT_DIR}/publish-collection.sh" "$BETA_SERVER" "$@"
