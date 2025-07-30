#!/usr/bin/env bash
# Install collections from production server
# Usage: ./bin/install-from-prod.sh [collection1 collection2 ...]

set -euo pipefail

# Source common functions and variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Get the root directory of the project
ROOT_DIR="$(realpath "${SCRIPT_DIR}/..")"

# If no collections specified, use all available
if [ $# -eq 0 ]; then
    mapfile -t COLLECTIONS < <(ls "${ROOT_DIR}/ansible-galaxy/collections/ansible_collections/levonk")
else
    COLLECTIONS=("$@")
fi

# Install each collection from production server
for collection in "${COLLECTIONS[@]}"; do
    echo "=== Installing levonk.${collection} from production server ==="
    ansible-galaxy collection install "levonk.${collection}" --force
    
    # Run test playbook if it exists
    test_playbook="${ROOT_DIR}/tests/test-levonk.${collection}.yml"
    if [ -f "${test_playbook}" ]; then
        echo "Running test playbook for levonk.${collection}..."
        ansible-playbook "${test_playbook}" "$@"
    fi
done

echo "Installation from production server complete."
