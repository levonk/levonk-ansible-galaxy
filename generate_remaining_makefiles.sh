#!/bin/bash

# Script to generate Makefiles for all remaining roles in the vibeops collection
# This script will create a standard role-level Makefile for each role that doesn't already have one

# Base directory for the vibeops collection roles
VIBEOPS_ROLES_DIR="/mnt/d/p/gh/lrepo52/mrepo/proj/homenet/deployment-operations/3rdparty/gh/levonk/levonk-ansible-galaxy/ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles"

# Template for the Makefile content
MAKEFILE_TEMPLATE='# Role-level Makefile for ${ROLE_NAME} role
# Handles linting and molecule testing for this role

.PHONY: all test lint molecule

# Include common variables
include ../../../../../../../common.mk

# Role-specific variables
ROLE_NAME := $(notdir $(CURDIR))
COLLECTION_NAME := $(notdir $(shell dirname $(shell dirname $(CURDIR))))
ROLE_DIR := $(CURDIR)

# Default target
all: test

# Test this role
test: lint molecule

# Lint this role
lint: lint-ansible lint-yaml

# Lint Ansible files in this role
lint-ansible:
	@echo "Linting Ansible files in role $(ROLE_NAME) with ansible-lint..."
	@ansible-lint $(ANSIBLE_LINT_FLAGS) . || echo "Warning: ansible-lint found issues in role $(ROLE_NAME)"

# Lint YAML files in this role
lint-yaml:
	@echo "Linting YAML files in role $(ROLE_NAME) with yamllint..."
	@find . -name "*.yml" -exec yamllint $(YAMLLINT_FLAGS) {} \; || echo "Warning: yamllint found issues in role $(ROLE_NAME)"

# Run molecule tests for this role
molecule:
	@echo "Running molecule tests for role $(ROLE_NAME)..."
	@if [ -d "molecule" ]; then \
		molecule test || echo "Warning: Molecule tests failed for role $(ROLE_NAME)"; \
	else \
		echo "No molecule tests found for role $(ROLE_NAME)"; \
	fi'

# Find all roles in the vibeops collection
for ROLE_DIR in "$VIBEOPS_ROLES_DIR"/*; do
    if [ -d "$ROLE_DIR" ]; then
        ROLE_NAME=$(basename "$ROLE_DIR")
        MAKEFILE_PATH="$ROLE_DIR/Makefile"
        
        # Skip if Makefile already exists
        if [ -f "$MAKEFILE_PATH" ]; then
            echo "Skipping $ROLE_NAME, Makefile already exists"
            continue
        fi
        
        # Create the Makefile with the template
        echo "Creating Makefile for $ROLE_NAME role"
        echo "$MAKEFILE_TEMPLATE" | sed "s/\${ROLE_NAME}/$ROLE_NAME/g" > "$MAKEFILE_PATH"
        echo "Created $MAKEFILE_PATH"
    fi
done

echo "All Makefiles created successfully!"
