#!/bin/bash
# Promote collections by incrementing the minor version number

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call the main promotion script with minor version increment
"${SCRIPT_DIR}/promote-versions.sh" --type=minor "$@"
