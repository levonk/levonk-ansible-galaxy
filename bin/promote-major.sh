#!/bin/bash
# Promote collections by incrementing the major version number

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call the main promotion script with major version increment
"${SCRIPT_DIR}/../ansible-galaxy/bin/promote-versions.sh" --type=major "$@"
