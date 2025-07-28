#!/bin/bash

# Script to update all Makefiles to use the top-level dist directory
ROOT_DIR="/mnt/d/p/gh/lrepo52/mrepo/proj/homenet/deployment-operations/3rdparty/gh/levonk/levonk-ansible-galaxy"
COLLECTIONS_DIR="$ROOT_DIR/ansible-galaxy/collections/ansible_collections/levonk"

# Create the top-level dist directory if it doesn't exist
mkdir -p "$ROOT_DIR/dist"

# Move any existing files from the old dist directory to the new one
if [ -d "$ROOT_DIR/ansible-galaxy/collections/ansible_collections/dist" ]; then
  echo "Moving files from old dist directory to new location..."
  cp -a "$ROOT_DIR/ansible-galaxy/collections/ansible_collections/dist/"* "$ROOT_DIR/dist/" 2>/dev/null
  echo "Done moving files."
fi

# Update collection Makefiles
echo "Updating collection Makefiles..."
find "$COLLECTIONS_DIR" -name "Makefile" -type f -exec grep -l "DIST_DIR" {} \; | while read makefile; do
  echo "Updating $makefile"
  # Count the number of parent directories to the ansible-galaxy directory
  rel_path=$(realpath --relative-to="$makefile" "$ROOT_DIR/ansible-galaxy")
  parent_count=$(echo "$rel_path" | tr -cd '/' | wc -c)
  
  # Create the new DIST_DIR path with the correct number of dirname calls
  new_path="DIST_DIR := \$(shell dirname"
  for ((i=0; i<$parent_count; i++)); do
    new_path="$new_path \$(shell dirname"
  done
  new_path="$new_path \$(CURDIR)"
  for ((i=0; i<$parent_count; i++)); do
    new_path="$new_path)"
  done
  new_path="$new_path)/../dist"
  
  # Replace the DIST_DIR line in the Makefile
  sed -i -E "s|DIST_DIR :=.*|$new_path|" "$makefile"
done

echo "All Makefiles have been updated to use the top-level dist directory."
