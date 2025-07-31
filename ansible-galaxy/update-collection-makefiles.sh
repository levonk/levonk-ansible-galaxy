#!/usr/bin/env bash
# Script to update Makefiles in all collections

set -euo pipefail

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLLECTIONS_DIR="$SCRIPT_DIR/collections/ansible_collections/levonk"

# Template for the collection Makefile
MAKEFILE_TEMPLATE='# Collection Makefile for levonk.%s

# Include shared Makefile from the parent directory
include ../../shared.mk

# Collection-specific variables
COLLECTION_NAME := %s

# Collection-specific targets can be added below
# Example:
# .PHONY: custom-target
# custom-target:
#	@echo "Running custom target for $(COLLECTION_NAME)"
'

echo "Updating Makefiles for collections in $COLLECTIONS_DIR"

# Find all collection directories (directories containing galaxy.yml)
while IFS= read -r -d $'\0' dir; do
    collection_dir="$(dirname "$dir")"
    collection_name="$(basename "$collection_dir")"
    
    echo "Processing collection: $collection_name"
    
    # Create or update the Makefile
    printf "$MAKEFILE_TEMPLATE" "$collection_name" "$collection_name" > "$collection_dir/Makefile"
    
    # Ensure the Makefile is executable
    chmod +x "$collection_dir/Makefile"
    
done < <(find "$COLLECTIONS_DIR" -mindepth 2 -maxdepth 2 -name "galaxy.yml" -print0)

echo "Makefile updates complete!"
