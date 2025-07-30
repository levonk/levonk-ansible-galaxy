#!/bin/bash
# publish20-prod.sh - Publish collections to production server
# Wrapper script for publish-collection.sh with production server configuration

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configuration
PROD_SERVER="https://galaxy.ansible.com"

# Call the main publish script with production server configuration
"${SCRIPT_DIR}/publish-collection.sh" "$PROD_SERVER" "$@"
