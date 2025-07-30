#!/bin/sh

# Common functions and variables for linting scripts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Status indicators
OK="[${GREEN}OK${NC}]"
ERROR="[${RED}ERROR${NC}]"
WARNING="[${YELLOW}WARNING${NC}]"

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Print error message and exit if not in NO_FAIL mode
fail() {
    echo "${ERROR} $1"
    if [ "$NO_FAIL" != "true" ]; then
        exit 1
    fi
}

# Print warning message
warn() {
    echo "${WARNING} $1"
}

# Print success message
success() {
    echo "${OK} $1"
}

# Get the collections directory
get_collections_dir() {
    echo "${COLLECTIONS_DIR:-collections/ansible_collections/levonk}"
}

# Get the list of collections
get_collections() {
    local collections_dir="$(get_collections_dir)"
    find "$collections_dir" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort
}

# Check if running in verbose mode
is_verbose() {
    [ "$VERBOSE" = "1" ] || [ "$VERBOSE" = "true" ]
}

# Check if running in quiet mode
is_quiet() {
    [ "$QUIET" = "1" ] || [ "$QUIET" = "true" ]
}
