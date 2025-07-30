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

# If no collections specified, use all available
if [ $# -eq 0 ]; then
    mapfile -t COLLECTIONS < <(ls "${ROOT_DIR}/ansible-galaxy/collections/ansible_collections/levonk")
else
    COLLECTIONS=("$@")
fi

# Install each collection from beta server
for collection in "${COLLECTIONS[@]}"; do
    echo "=== Installing levonk.${collection} from beta server ==="
    ansible-galaxy collection install "levonk.${collection}" --server "${GALAXY_SERVER}" --force
    
    # Run test playbook if it exists
    test_playbook="${ROOT_DIR}/tests/test-levonk.${collection}.yml"
    if [ -f "${test_playbook}" ]; then
        echo "Running test playbook for levonk.${collection}..."
        ansible-playbook "${test_playbook}" "$@"
    fi
done

echo "Installation from beta server complete."
