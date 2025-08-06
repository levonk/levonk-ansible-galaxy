#!/usr/bin/env bash
# Build an Ansible collection
# Usage: build10-collection.sh <collection_name> <collections_dir> <dist_dir> <namespace>

set -euo pipefail

# Check for required arguments
if [ $# -ne 4 ]; then
    echo "Usage: $0 <collection_name> <collections_dir> <dist_dir> <namespace>"
    exit 1
fi

COLLECTION="$1"
COLLECTIONS_DIR="$2"
DIST_DIR="$3"
NAMESPACE="${4:-levonk}"

# Ensure collections directory exists
if [ ! -d "${COLLECTIONS_DIR}" ]; then
    echo "Error: Collections directory not found: ${COLLECTIONS_DIR}"
    exit 1
fi

# Ensure dist directory exists
mkdir -p "${DIST_DIR}"

# Build the collection
echo "Building collection ${NAMESPACE}.${COLLECTION}..."
COLLECTION_PATH="${COLLECTIONS_DIR}/ansible_collections/${NAMESPACE}/${COLLECTION}"

if [ ! -d "${COLLECTION_PATH}" ]; then
    echo "Error: Collection directory not found: ${COLLECTION_PATH}"
    exit 1
fi

# Change to collections directory to build from the correct context
cd "${COLLECTIONS_DIR}" || exit 1

# Clean up any existing build artifacts
rm -f "${DIST_DIR}/${NAMESPACE}-${COLLECTION}-"*.tar.gz

# Find and remove any existing build directories
find "${COLLECTIONS_DIR}" -type d -name "${COLLECTION}-build" -exec rm -rf {} + 2>/dev/null || true

# Build the collection with force flag to overwrite existing files
ansible-galaxy collection build --force \
    --output-path "${DIST_DIR}" \
    "ansible_collections/${NAMESPACE}/${COLLECTION}" \
    || { echo "Failed to build collection ${NAMESPACE}.${COLLECTION}"; exit 1; }

# Verify the tarball was created
if ! ls "${DIST_DIR}/${NAMESPACE}-${COLLECTION}-"*.tar.gz 1> /dev/null 2>&1; then
    echo "Error: Failed to create collection tarball for ${NAMESPACE}.${COLLECTION}"
    exit 1
fi

echo "Collection built successfully: ${DIST_DIR}/${NAMESPACE}-${COLLECTION}-*.tar.gz"
