#!/usr/bin/env bash
# Script to update Makefiles in all collections to follow the project standards
# This script updates or creates Makefiles in all collections to delegate to the top-level Makefile
# with the appropriate collection name.

set -euo pipefail

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"
COLLECTIONS_DIR="$ROOT_DIR/collections/ansible_collections/levonk"
TEMPLATE_FILE="$ROOT_DIR/collections/ansible_collections/blueprint-namespace/blueprint-collection/Makefile"

# Check if we're in the correct directory
if [ ! -d "$COLLECTIONS_DIR" ]; then
    echo "Error: Could not find collections directory at $COLLECTIONS_DIR"
    echo "Please run this script from the ansible-galaxy directory"
    exit 1
fi

# Check if template file exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Could not find Makefile template at $TEMPLATE_FILE"
    exit 1
fi

echo "Updating Makefiles for collections in $COLLECTIONS_DIR"

# Create a backup of existing Makefiles
BACKUP_DIR="/tmp/makefile_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to process a collection directory
process_collection() {
    local collection_dir="$1"
    local collection_name="$(basename "$collection_dir")"
    local makefile_path="$collection_dir/Makefile"
    
    echo "Processing collection: $collection_name"
    
    # Create backup of existing Makefile if it exists
    if [ -f "$makefile_path" ]; then
        mkdir -p "$BACKUP_DIR/$collection_name"
        cp "$makefile_path" "$BACKUP_DIR/$collection_name/Makefile.$(date +%Y%m%d_%H%M%S)"
        echo "  - Backed up existing Makefile to $BACKUP_DIR/$collection_name/"
    fi
    
    # Generate the new Makefile from template
    # First, get the namespace from the directory structure
    namespace=$(basename $(dirname $(dirname $(dirname "$collection_dir"))))
    
    # Create a temporary file for the processed template
    cp "$TEMPLATE_FILE" "$makefile_path.tmp"
    
    # Replace template variables
    sed -i "s/{{ collection_name }}/$collection_name/g" "$makefile_path.tmp"
    sed -i "s/{{ namespace_name }}/$namespace/g" "$makefile_path.tmp"
    
    # Check if the file has changed
    if [ -f "$makefile_path" ] && cmp -s "$makefile_path" "$makefile_path.tmp"; then
        echo "  - No changes needed for $collection_name/Makefile"
        rm "$makefile_path.tmp"
    else
        mv "$makefile_path.tmp" "$makefile_path"
        echo "  - Updated $collection_name/Makefile"
    fi
}

export -f process_collection
export BACKUP_DIR TEMPLATE_FILE

# Process each collection directory
find "$COLLECTIONS_DIR" -mindepth 1 -maxdepth 1 -type d -not -name '.*' -print0 | while IFS= read -r -d $'\0' collection_dir; do
    process_collection "$collection_dir"
done

echo -e "\nMakefile update complete!"
echo "Backup of original Makefiles is available at: $BACKUP_DIR"
