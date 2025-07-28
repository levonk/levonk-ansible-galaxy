#!/bin/bash
# Script to set up a new Ansible role with all required files
# Usage: ./setup_new_role.sh <collection_name> <role_name>

# Check if collection and role names are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <collection_name> <role_name>"
  echo "Example: $0 common my_new_role"
  exit 1
fi

COLLECTION_NAME="$1"
ROLE_NAME="$2"
BASE_DIR="/mnt/d/p/gh/lrepo52/mrepo/proj/homenet/deployment-operations/3rdparty/gh/levonk/levonk-ansible-galaxy/ansible-galaxy"
ROLE_DIR="$BASE_DIR/collections/ansible_collections/levonk/$COLLECTION_NAME/roles/$ROLE_NAME"
TEMPLATES_DIR="$BASE_DIR/collections/ansible_collections/blueprint-namespace/templates"

echo "Setting up new role: $ROLE_NAME in collection levonk.$COLLECTION_NAME"

# Check if collection exists
if [ ! -d "$BASE_DIR/collections/ansible_collections/levonk/$COLLECTION_NAME" ]; then
  echo "Error: Collection levonk.$COLLECTION_NAME does not exist."
  echo "Create it first with: ./setup_new_collection.sh $COLLECTION_NAME"
  exit 1
fi

# Create role directory structure
mkdir -p "$ROLE_DIR"/{defaults,files,handlers,meta,tasks,templates,vars}

# Create meta/main.yml - REQUIRED for Galaxy publishing to avoid warnings
cat > "$ROLE_DIR/meta/main.yml" << EOF
# meta/main.yml for roles - this file is required for Ansible Galaxy
---
galaxy_info:
  role_name: $ROLE_NAME
  author: levonk
  description: Role for $ROLE_NAME functionality in the $COLLECTION_NAME collection
  company: levonk
  license: MIT
  min_ansible_version: 2.9
  
  platforms:
    - name: Ubuntu
      versions:
        - focal
        - jammy
    - name: Debian
      versions:
        - bullseye
        - bookworm
  
  galaxy_tags:
    - levonk
    - $COLLECTION_NAME

dependencies: []
EOF

# Create README.md
cat > "$ROLE_DIR/README.md" << EOF
# $ROLE_NAME

Role for $ROLE_NAME functionality in the $COLLECTION_NAME collection.

## Requirements

Any prerequisites that may not be covered by Ansible itself or the role.

## Role Variables

A description of the variables used by this role:

| Variable | Default | Description |
|----------|---------|-------------|
| example_var | default_value | Description of the variable |

## Dependencies

None.

## Example Playbook

\`\`\`yaml
- hosts: servers
  roles:
    - role: levonk.$COLLECTION_NAME.$ROLE_NAME
      vars:
        example_var: value
\`\`\`
EOF

# Create default tasks/main.yml
cat > "$ROLE_DIR/tasks/main.yml" << EOF
---
# tasks file for $ROLE_NAME
- name: Include variables
  include_vars: "{{ item }}"
  with_first_found:
    - "{{ ansible_distribution | lower }}-{{ ansible_distribution_version }}.yml"
    - "{{ ansible_distribution | lower }}-{{ ansible_distribution_major_version }}.yml"
    - "{{ ansible_distribution | lower }}.yml"
    - "{{ ansible_os_family | lower }}.yml"
    - "default.yml"
  ignore_errors: true
  tags:
    - always
EOF

# Create default defaults/main.yml
cat > "$ROLE_DIR/defaults/main.yml" << EOF
---
# defaults file for $ROLE_NAME
EOF

# Create Makefile for the role
cp "$TEMPLATES_DIR/Makefile.role.template" "$ROLE_DIR/Makefile"
sed -i "s/ROLE_NAME=.*/ROLE_NAME=$ROLE_NAME/" "$ROLE_DIR/Makefile"

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
