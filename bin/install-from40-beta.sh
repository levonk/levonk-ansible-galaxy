#!/usr/bin/env bash
# Install collections from beta server
# Usage: ./bin/install-from-beta.sh [collection1 collection2 ...]

set -euo pipefail

# Source common functions and variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Get the root directory of the project
ROOT_DIR="$(realpath "${SCRIPT_DIR}/..")"
GALAXY_SERVER="https://galaxy-dev.ansible.com"

# If no collections specified, use all available collections
if [ $# -eq 0 ]; then
    # Find all collection directories (skip files like README.md)
    while IFS= read -r -d '' dir; do
        if [ -d "${dir}" ] && [ -f "${dir}/galaxy.yml" ]; then
            COLLECTIONS+=("$(basename "${dir}")")
        fi
    done < <(find "${ROOT_DIR}/ansible-galaxy/collections/ansible_collections/levonk" -mindepth 1 -maxdepth 1 -type d -print0)
    
    if [ ${#COLLECTIONS[@]} -eq 0 ]; then
        echo "No valid collections found in ${ROOT_DIR}/ansible-galaxy/collections/ansible_collections/levonk"
        exit 1
    fi
    
    echo "Found collections to install: ${COLLECTIONS[*]}"
else
    COLLECTIONS=("$@")
fi

# Install each collection from beta server
for collection in "${COLLECTIONS[@]}"; do
    echo "=== Installing levonk.${collection} from beta server ==="
    ansible-galaxy collection install "levonk.${collection}" --server "${GALAXY_SERVER}" --force --pre
    
    # Run test playbook if it exists
    test_playbook="${ROOT_DIR}/tests/test-levonk.${collection}.yml"
    if [ -f "${test_playbook}" ]; then
        echo "Running test playbook for levonk.${collection}..."
        ansible-playbook "${test_playbook}" "$@"
    fi
done

echo "Installation from beta server complete."
