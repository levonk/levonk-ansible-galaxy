#!/usr/bin/env bash
# Install collections from git repository
# Usage: ./bin/install-from-repo.sh [branch] [collection1 collection2 ...]

set -euo pipefail

# Source common functions and variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Get the root directory of the project
ROOT_DIR="$(realpath "${SCRIPT_DIR}/..")"
REPO_URL="https://github.com/levonk/levonk-ansible-galaxy.git"
TEMP_DIR="$(mktemp -d)"

# Default branch is main
BRANCH="${1:-main}"
shift || true

# If no collections specified, use all available
if [ $# -eq 0 ]; then
    mapfile -t COLLECTIONS < <(ls "${ROOT_DIR}/ansible-galaxy/collections/ansible_collections/levonk")
else
    COLLECTIONS=("$@")
fi

# Clone the repository
echo "Cloning repository (branch: ${BRANCH})..."
git clone --depth 1 --branch "${BRANCH}" "${REPO_URL}" "${TEMP_DIR}"

# Install each collection
for collection in "${COLLECTIONS[@]}"; do
    echo "=== Installing levonk.${collection} from repository ==="
    ansible-galaxy collection install "${TEMP_DIR}/ansible-galaxy/collections/ansible_collections/levonk/${collection}" --force
    
    # Run test playbook if it exists
    test_playbook="${TEMP_DIR}/tests/test-levonk.${collection}.yml"
    if [ -f "${test_playbook}" ]; then
        echo "Running test playbook for levonk.${collection}..."
        ansible-playbook "${test_playbook}" "$@"
    fi
done

# Clean up
rm -rf "${TEMP_DIR}"
echo "Installation from repository complete."
