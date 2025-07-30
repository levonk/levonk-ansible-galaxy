#!/usr/bin/env bash
# Install collections from built artifacts
# Usage: ./bin/install-from-build.sh [collection1 collection2 ...]

set -euo pipefail

# Source common functions and variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Get the root directory of the project
ROOT_DIR="$(realpath "${SCRIPT_DIR}/..")"
DIST_DIR="${ROOT_DIR}/ansible-galaxy/dist"

# If no collections specified, install all found in dist
if [ $# -eq 0 ]; then
    mapfile -t PACKAGES < <(find "${DIST_DIR}" -name "levonk-*.tar.gz" -type f -exec basename {} \; | sort -u)
else
    PACKAGES=()
    for collection in "$@"; do
        # Find the latest version of each specified collection
        latest_pkg=$(find "${DIST_DIR}" -name "levonk-${collection}-*.tar.gz" -type f -printf "%T@ %p\n" | sort -nr | head -1 | cut -d' ' -f2-)
        if [ -n "$latest_pkg" ]; then
            PACKAGES+=("$latest_pkg")
        fi
    done
fi

# Install each package
for pkg in "${PACKAGES[@]}"; do
    echo "=== Installing ${pkg} from build artifacts ==="
    ansible-galaxy collection install "${DIST_DIR}/${pkg##*/}" --force
    
    # Extract collection name from package
    collection_name=$(basename "${pkg}" | sed -E 's/^levonk-([^-]+)-.*\.tar\.gz$/\1/')
    
    # Run test playbook if it exists
    test_playbook="${ROOT_DIR}/tests/test-levonk.${collection_name}.yml"
    if [ -f "${test_playbook}" ]; then
        echo "Running test playbook for levonk.${collection_name}..."
        ansible-playbook "${test_playbook}" "$@"
    fi
done

echo "Installation from build artifacts complete."
