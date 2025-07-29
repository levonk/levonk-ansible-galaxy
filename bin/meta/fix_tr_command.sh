#!/bin/bash

# Fix the unescaped backslash in tr command in all collection Makefiles
collections_dir="ansible-galaxy/collections/ansible_collections/"

# Find all collection Makefiles and fix the tr command
for makefile in $(find "$collections_dir" -name "Makefile"); do
  echo "Fixing $makefile"
  sed -i "s/tr -d '\"\\\''/tr -d '\"' | tr -d \"'\"/g" "$makefile"
done

echo "All Makefiles fixed"
