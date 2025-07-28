#!/bin/bash
# Script to set up a new Ansible collection with all required files
# Usage: ./setup_new_collection.sh <collection_name>

# Check if collection name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <collection_name>"
  echo "Example: $0 my_collection"
  exit 1
fi

COLLECTION_NAME="$1"
BASE_DIR="/mnt/d/p/gh/lrepo52/mrepo/proj/homenet/deployment-operations/3rdparty/gh/levonk/levonk-ansible-galaxy/ansible-galaxy"
COLLECTION_DIR="$BASE_DIR/collections/ansible_collections/levonk/$COLLECTION_NAME"
TEMPLATES_DIR="$BASE_DIR/collections/ansible_collections/blueprint-namespace/templates"

echo "Setting up new collection: levonk.$COLLECTION_NAME"

# Create collection directory structure
mkdir -p "$COLLECTION_DIR"/{meta,roles,plugins,docs,playbooks,files,defaults,tests}

# Create galaxy.yml file
cat > "$COLLECTION_DIR/galaxy.yml" << EOF
---
namespace: levonk
name: $COLLECTION_NAME
version: 1.0.0
readme: README.md
authors:
  - levonk
description: Levonk $COLLECTION_NAME collection
license:
  - MIT
tags:
  - levonk
  - ansible
  - collection
repository: https://github.com/levonk/levonk-ansible-galaxy
documentation: https://github.com/levonk/levonk-ansible-galaxy
homepage: https://github.com/levonk/levonk-ansible-galaxy
issues: https://github.com/levonk/levonk-ansible-galaxy/issues
EOF

# Create README.md
cat > "$COLLECTION_DIR/README.md" << EOF
# levonk.$COLLECTION_NAME collection

Documentation for the $COLLECTION_NAME collection.

## Roles

This collection contains the following roles:

(Add role descriptions here)

## Usage

Example playbook:

\`\`\`yaml
---
- name: Use $COLLECTION_NAME collection
  hosts: all
  roles:
    - role: levonk.$COLLECTION_NAME.role_name
\`\`\`
EOF

# Create meta/runtime.yml - REQUIRED for Galaxy publishing
cat > "$COLLECTION_DIR/meta/runtime.yml" << EOF
#SPDX-License-Identifier: MIT-0
---
# Collections must specify a minimum required ansible version to upload
# to galaxy - THIS IS MANDATORY FOR GALAXY PUBLISHING
requires_ansible: '>=2.9.10'

# Content that Ansible needs to load from another location or that has
# been deprecated/removed
# plugin_routing:
#   action:
EOF

# Create Makefile for the collection
cp "$TEMPLATES_DIR/Makefile.collection.template" "$COLLECTION_DIR/Makefile"

echo "Collection structure created at: $COLLECTION_DIR"
echo ""
echo "Next steps:"
echo "1. Add roles to the collection in $COLLECTION_DIR/roles/"
echo "2. Make sure each role has a meta/main.yml file with a proper description"
echo "3. Update the README.md with specific information about your collection"
echo "4. Build the collection with: make build"
echo ""
echo "IMPORTANT: When creating roles, ensure each role has a meta/main.yml file with a proper description"
echo "to avoid Galaxy import warnings."
