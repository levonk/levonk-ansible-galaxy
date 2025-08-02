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

# If no collections specified, use all available collections
if [ $# -eq 0 ]; then
    # Find all collection directories (skip files like README.md)
    while IFS= read -r -d '' dir; do
        if [ -d "${dir}" ] && [ -f "${dir}/galaxy.yml" ]; then
            COLLECTIONS+=("$(basename "${dir}")")
        fi
    done < <(find "${COLLECTIONS_DIR}" -mindepth 1 -maxdepth 1 -type d -print0)
    
    if [ ${#COLLECTIONS[@]} -eq 0 ]; then
        echo "No valid collections found in ${COLLECTIONS_DIR}"
        exit 1
    fi
    
    echo "Found collections to install: ${COLLECTIONS[*]}"
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
    fi
done

echo "Installation from source complete."
