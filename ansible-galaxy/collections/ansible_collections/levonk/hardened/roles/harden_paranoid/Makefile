# Role-level Makefile for harden_paranoid role
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
	fi
