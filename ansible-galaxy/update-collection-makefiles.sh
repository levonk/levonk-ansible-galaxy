#!/usr/bin/env bash
# Script to update Makefiles in all collections to follow the project standards
# This script updates or creates Makefiles in all collections to include the shared.mk
# and follow the project's Makefile standards.

set -euo pipefail

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"
COLLECTIONS_DIR="$ROOT_DIR/collections/ansible_collections/levonk"

# Template for the collection Makefile
MAKEFILE_TEMPLATE='# ====================================================================
# %s Collection
# ====================================================================

# Collection-specific variables
COLLECTION_NAME := %s

# Calculate the path to the ansible-galaxy directory
ANSIBLE_GALAXY_DIR := $(shell cd $(dir $(lastword $(MAKEFILE_LIST)))/../../../.. && pwd)

# ====================================================================
# Include shared Makefiles
# ====================================================================

# Include shared Makefile from the ansible-galaxy directory
include $(ANSIBLE_GALAXY_DIR)/shared.mk

# Include the shared targets (build, test, lint, etc.)
include $(ANSIBLE_GALAXY_DIR)/shared-targets.mk

# ====================================================================
# Collection-specific Targets
# ====================================================================

# Add collection-specific targets below this line
# Example:
# .PHONY: custom-target
# custom-target: ## Example custom target
#	@echo "Running custom target for $(COLLECTION_NAME)"
'

echo "Updating Makefiles for collections in $COLLECTIONS_DIR"

# Create a backup of existing Makefiles
BACKUP_DIR="/tmp/makefile_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Find all collection directories (directories containing galaxy.yml)
while IFS= read -r -d $'\0' dir; do
    collection_dir="$(dirname "$dir")"
    collection_name="$(basename "$collection_dir")"
    
    echo "Processing collection: $collection_name"
    
    # Backup existing Makefile if it exists
    if [ -f "$collection_dir/Makefile" ]; then
        cp "$collection_dir/Makefile" "$BACKUP_DIR/${collection_name}_Makefile.bak"
        echo "  - Backed up existing Makefile to $BACKUP_DIR/${collection_name}_Makefile.bak"
    fi
    
    # Create or update the Makefile
    printf "$MAKEFILE_TEMPLATE" "$collection_name" "$collection_name" > "$collection_dir/Makefile"
    echo "  - Updated Makefile"
    
    # Ensure the Makefile has the correct permissions
    chmod 644 "$collection_dir/Makefile"
    
done < <(find "$COLLECTIONS_DIR" -mindepth 2 -maxdepth 2 -name "galaxy.yml" -print0)

# Also update the top-level collection Makefile
TOP_LEVEL_MAKEFILE="$COLLECTIONS_DIR/../Makefile"
if [ -f "$TOP_LEVEL_MAKEFILE" ]; then
    cp "$TOP_LEVEL_MAKEFILE" "$BACKUP_DIR/top_level_Makefile.bak"
    echo "Backed up top-level Makefile to $BACKUP_DIR/top_level_Makefile.bak"
    
    cat > "$TOP_LEVEL_MAKEFILE" << 'EOL'
# ====================================================================
# Ansible Collections - Top Level
# ====================================================================

# Include shared Makefile from the ansible_collections directory
include shared.mk

# List of all collections to process
COLLECTIONS := $(notdir $(wildcard */))

# ====================================================================
# Default Target
# ====================================================================

.DEFAULT_GOAL := help

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mAnsible Collections - Available Targets\033[0m"
	@echo "================================================="
	@echo "\n\033[1mBuild Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# ====================================================================
# Collection Operations
# ====================================================================

# Forward all other targets to all collections
%:
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Running '$@' on collection: $$collection ==="; \
		$(MAKE) -C "$$collection" $@ || exit 1; \
	done

# ====================================================================
# Special Targets
# ====================================================================

# Add any special targets that should only run once (not per-collection) here

EOL
    
    echo "Updated top-level Makefile"
fi

echo -e "\nMakefile updates complete!"
echo "Original Makefiles were backed up to: $BACKUP_DIR"
