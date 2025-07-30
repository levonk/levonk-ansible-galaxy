#!/usr/bin/env bash
# Install collections from source directories
# Usage: ./bin/install-from-src.sh [collection1 collection2 ...]

set -euo pipefail

# Source common functions and variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Get the root directory of the project
ROOT_DIR="$(realpath "${SCRIPT_DIR}/..")"
COLLECTIONS_DIR="${ROOT_DIR}/ansible-galaxy/collections/ansible_collections/levonk"

# If no collections specified, use all available
if [ $# -eq 0 ]; then
    mapfile -t COLLECTIONS < <(ls "${COLLECTIONS_DIR}")
else
    COLLECTIONS=("$@")
fi

# Install each collection from source
for collection in "${COLLECTIONS[@]}"; do
    if [ -d "${COLLECTIONS_DIR}/${collection}" ]; then
        echo "=== Installing levonk.${collection} from source ==="
        ansible-galaxy collection install "${COLLECTIONS_DIR}/${collection}" --force
        
        # Run test playbook if it exists
        test_playbook="${ROOT_DIR}/tests/test-levonk.${collection}.yml"
        if [ -f "${test_playbook}" ]; then
            echo "Running test playbook for levonk.${collection}..."
            ansible-playbook "${test_playbook}" "$@"
        fi
    else
        echo "Warning: Collection '${collection}' not found in ${COLLECTIONS_DIR}" >&2
    
done

echo "Installation from source complete."
