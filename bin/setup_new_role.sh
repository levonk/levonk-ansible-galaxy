#!/bin/bash
# Script to set up a new Ansible role with all required files using copier
# Usage: ./setup_new_role.sh <collection_name> <role_name>

set -e  # Exit immediately if a command exits with a non-zero status

# Check if collection and role names are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <collection_name> <role_name>"
  echo "Example: $0 common my_new_role"
  exit 1
fi

COLLECTION_NAME="$1"
ROLE_NAME="$2"

# Use relative paths based on script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BASE_DIR="$ROOT_DIR/ansible-galaxy"
BLUEPRINT_ROLE="$BASE_DIR/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role"

echo "Setting up new role: $ROLE_NAME in collection levonk.$COLLECTION_NAME"

# Check if collection exists
if [ ! -d "$BASE_DIR/collections/ansible_collections/levonk/$COLLECTION_NAME" ]; then
  echo "Error: Collection levonk.$COLLECTION_NAME does not exist."
  echo "Create it first with: ./setup_new_collection.sh $COLLECTION_NAME"
  exit 1
fi

# Create the role directory if it doesn't exist
COLLECTION_DIR="$BASE_DIR/collections/ansible_collections/levonk/$COLLECTION_NAME"
ROLE_DIR="$COLLECTION_DIR/roles/$ROLE_NAME"
mkdir -p "$COLLECTION_DIR/roles"

# Check if role already exists
if [ -d "$ROLE_DIR" ]; then
  echo "Warning: Role '$ROLE_NAME' already exists in collection '$COLLECTION_NAME'."
  read -p "Do you want to overwrite it? (y/N): " confirm
  if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 1
  fi
fi

echo "Creating role using copier template..."
# Use copier to create the role from the blueprint template
copier copy \
  "$BLUEPRINT_ROLE" \
  "$ROLE_DIR" \
  --data "role_name=$ROLE_NAME" \
  --data "collection_name=$COLLECTION_NAME" \
  --data "namespace=levonk" \
  --force

echo "Role has been created with all necessary Galaxy metadata files"

ROLE_DIR="$BASE_DIR/collections/ansible_collections/levonk/$COLLECTION_NAME/roles/$ROLE_NAME"

echo "Role structure created at: $ROLE_DIR"
echo ""
echo "Next steps:"
echo "1. Update the role description in $ROLE_DIR/meta/main.yml"
echo "2. Add tasks to $ROLE_DIR/tasks/main.yml"
echo "3. Define default variables in $ROLE_DIR/defaults/main.yml"
echo "4. Update the README.md with specific information about your role"
echo ""
echo "IMPORTANT: Make sure the description in meta/main.yml is detailed and accurate"
echo "to avoid Galaxy import warnings."
echo ""
echo "REMINDER: Ansible Galaxy requirements for roles:"
echo "- All roles must have meta/main.yml with proper description"
echo "- All roles must have meta/runtime.yml with requires_ansible field"
echo "- Role names must use lowercase letters, numbers, and underscores only (no hyphens)"
echo "- Galaxy tags must use lowercase letters, numbers, and underscores only (no hyphens)"
