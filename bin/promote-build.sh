#!/bin/bash
# Promote collections by incrementing the build version number (patch)

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call the main promotion script with build version increment
"${SCRIPT_DIR}/../ansible-galaxy/bin/promote-versions.sh" --type=build "$@"
