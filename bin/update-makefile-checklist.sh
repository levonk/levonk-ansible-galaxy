#!/bin/bash
# ==============================================================================
# update-makefile-checklist.sh - Makefile Standardization Documentation Updater
# ==============================================================================
#
# This script scans the repository for all Makefiles and generates/updates a
# checklist in the success criteria document (20250804-makefiles-success.md).
# It helps track which Makefiles have been standardized according to the
# project's Makefile standards.
#
# Features:
# - Scans for all Makefiles in the repository
# - Organizes Makefiles by directory level (root, Ansible Galaxy, collection, role)
# - Handles special cases for blueprint templates
# - Adds timestamps to track when the checklist was last updated
# - Maintains the existing document structure while updating the checklist section
#
# Usage:
#   ./bin/update-makefile-checklist.sh
#
# Note: This script is typically run as part of CI/CD pipelines or during
# development to keep the Makefile standardization documentation current.
# ==============================================================================

# Set the repository root directory
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUCCESS_DOC="$REPO_ROOT/internal-docs/tasks/20250804-makefiles-success.md"

# Create a temporary file for the updated document
temp_file=$(mktemp)

# Copy the header of the document to the temp file
sed -n '1,/^## Makefiles Checklist/p' "$SUCCESS_DOC" > "$temp_file"

# Add timestamp
echo "_Last updated: $(date '+%Y-%m-%d %H:%M:%S')_" >> "$temp_file"
echo "" >> "$temp_file"

# Find all Makefiles and organize them by directory level
find "$REPO_ROOT" -name 'Makefile' | sort | while read -r makefile; do
    # Get the relative path from the repo root
    rel_path="${makefile#$REPO_ROOT/}"
    
    # Determine the indentation level based on directory depth
    depth=$(echo "$rel_path" | tr -cd '/' | wc -c)
    indent=""
    
    # Add appropriate markdown headers based on depth
    case $depth in
        0) echo "### Root Level" >> "$temp_file" ;;
        1) echo -e "\n### Ansible Galaxy" >> "$temp_file" ;;
        *)
            # For deeper paths, determine if it's a collection, role, etc.
            if [[ $rel_path == *"collections/ansible_collections/"* ]]; then
                if [[ $rel_path == *"/roles/"* ]]; then
                    # Role level
                    if [[ $rel_path == *"blueprint-namespace"* ]]; then
                        echo -e "\n#### Blueprint Role Templates" >> "$temp_file"
                    else
                        echo -e "\n#### Role Level" >> "$temp_file"
                    fi
                elif [[ $rel_path == *"/ansible_collections/"*/*"/"* ]]; then
                    # Collection level
                    if [[ $rel_path == *"blueprint-namespace"* ]]; then
                        echo -e "\n#### Blueprint Collections" >> "$temp_file"
                    else
                        echo -e "\n#### Collection Level" >> "$temp_file"
                    fi
                fi
            fi
            ;;
    esac
    
    # Add the Makefile to the list
    echo "- [ ] \`$rel_path\`" >> "$temp_file"
done

# Add the rest of the original document
echo -e "\n## Implementation Steps" >> "$temp_file"
sed -n '/^## Implementation Steps/,$p' "$SUCCESS_DOC" | tail -n +2 >> "$temp_file"

# Replace the original document with the updated one
mv "$temp_file" "$SUCCESS_DOC"

echo "Successfully updated Makefile checklist in $SUCCESS_DOC"
