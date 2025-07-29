#!/bin/bash
# Script to set up a new Ansible collection with all required files using copier
# Usage: ./setup_new_collection.sh <collection_name>

set -e  # Exit immediately if a command exits with a non-zero status

# Check if collection name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <collection_name>"
  echo "Example: $0 my_collection"
  exit 1
fi

COLLECTION_NAME="$1"

# Use relative paths based on script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BASE_DIR="$ROOT_DIR/ansible-galaxy"
COLLECTIONS_DIR="$BASE_DIR/collections/ansible_collections/levonk"
BLUEPRINT_COLLECTION="$BASE_DIR/collections/ansible_collections/blueprint-namespace/blueprint-collection"

echo "Setting up new collection: levonk.$COLLECTION_NAME"

# Check if collection already exists
if [ -d "$COLLECTIONS_DIR/$COLLECTION_NAME" ]; then
  echo "Warning: Collection 'levonk.$COLLECTION_NAME' already exists at $COLLECTIONS_DIR/$COLLECTION_NAME"
  read -p "Do you want to overwrite it? (y/N): " confirm
  if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 1
  fi
fi

# Use copier to create the collection from the blueprint template
echo "Creating collection using copier template..."
copier copy \
  "$BLUEPRINT_COLLECTION" \
  "$COLLECTIONS_DIR/$COLLECTION_NAME" \
  --data "collection_name=$COLLECTION_NAME" \
  --data "namespace=levonk" \
  --force

echo "Collection has been created with all necessary Galaxy metadata files"

echo "Collection structure created at: $COLLECTIONS_DIR/$COLLECTION_NAME"
echo ""
echo "Next steps:"
echo "1. Add roles to the collection in $COLLECTIONS_DIR/$COLLECTION_NAME/roles/"
echo "2. Make sure each role has a meta/main.yml file with a proper description"
echo "3. Update the README.md with specific information about your collection"
echo "4. Build the collection with: make build"
echo ""
echo "REMINDER: Ansible Galaxy requirements for collections:"
echo "- All roles must have meta/main.yml with proper description"
echo "- All roles must have meta/runtime.yml with requires_ansible field"
echo "- Role names must use lowercase letters, numbers, and underscores only (no hyphens)"
echo "- Collection version strings must follow semantic versioning"
echo "- Galaxy tags must use lowercase letters, numbers, and underscores only (no hyphens)"
