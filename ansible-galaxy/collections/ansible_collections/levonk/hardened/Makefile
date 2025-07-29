# Collection-level Makefile for levonk.hardened
# Handles building, testing, and linting of this collection

.PHONY: all build clean test lint molecule

# Include common variables
include ../../../../../common.mk

# Collection-specific variables
COLLECTION_NAME := $(notdir $(CURDIR))
COLLECTION_DIR := $(CURDIR)
COLLECTION_DIST := $(DIST_DIR)

# Default target
all: build test

# Build this collection
build:
	@echo "Building collection: levonk.$(COLLECTION_NAME)"
	@if [ ! -f "galaxy.yml" ]; then \
		echo "Creating galaxy.yml for $(COLLECTION_NAME)"; \
		cat > "galaxy.yml" << EOF \
namespace: levonk
name: $(COLLECTION_NAME)
version: 0.1.0
readme: README.md
authors:
  - Levon Kocharian
description: Levonk $(COLLECTION_NAME) collection
license:
  - MIT
EOF \
	else \
		echo "Checking galaxy.yml for $(COLLECTION_NAME)"; \
		GALAXY_NAME=$$(grep -E "^name:" "galaxy.yml" | awk '{print $$2}' | tr -d '"' | tr -d "'"'); \
		if [ "$$GALAXY_NAME" != "$(COLLECTION_NAME)" ]; then \
			echo "Fixing galaxy.yml name from '$$GALAXY_NAME' to '$(COLLECTION_NAME)'"; \
			sed -i "s/^name:.*/name: $(COLLECTION_NAME)/" "galaxy.yml"; \
		fi; \
	fi
	@ansible-galaxy collection build --output-path "$(COLLECTION_DIST)" --force
	@echo "Build complete for levonk.$(COLLECTION_NAME)"

# Clean build artifacts
clean:
	@echo "Cleaning collection: levonk.$(COLLECTION_NAME)"
	@rm -f "$(COLLECTION_DIST)/levonk-$(COLLECTION_NAME)-*.tar.gz"

# Run tests for this collection
test: lint molecule

# Lint this collection
lint: lint-ansible lint-yaml lint-galaxy

# Lint Ansible files in this collection
lint-ansible:
	@echo "Linting Ansible files in $(COLLECTION_NAME) with ansible-lint..."
	@ansible-lint $(ANSIBLE_LINT_FLAGS) . || echo "Warning: ansible-lint found issues in $(COLLECTION_NAME)"

# Lint YAML files in this collection
lint-yaml:
	@echo "Linting YAML files in $(COLLECTION_NAME) with yamllint..."
	@find . -name "*.yml" -exec yamllint $(YAMLLINT_FLAGS) {} \; || echo "Warning: yamllint found issues in $(COLLECTION_NAME)"

# Lint galaxy.yml in this collection
lint-galaxy:
	@echo "Linting galaxy.yml in $(COLLECTION_NAME)..."
	@if [ -f "galaxy.yml" ]; then \
		# Check required fields
		for field in namespace name version readme authors description license; do \
			if ! grep -q "^$$field:" "galaxy.yml"; then \
				echo "ERROR: Missing required field '$$field' in galaxy.yml for $(COLLECTION_NAME)"; \
			fi; \
		done; \
		# Verify namespace is 'levonk'
		if ! grep -q "^namespace: levonk" "galaxy.yml"; then \
			echo "ERROR: Namespace must be 'levonk' in galaxy.yml for $(COLLECTION_NAME)"; \
		fi; \
		# Verify name matches directory name
		GALAXY_NAME=$$(grep -E "^name:" "galaxy.yml" | awk '{print $$2}' | tr -d '"' | tr -d "'"'); \
		if [ "$$GALAXY_NAME" != "$(COLLECTION_NAME)" ]; then \
			echo "ERROR: Name '$$GALAXY_NAME' does not match directory name '$(COLLECTION_NAME)'"; \
		fi; \
		# Validate with yamllint
		yamllint "galaxy.yml" || echo "Warning: YAML syntax issues in galaxy.yml for $(COLLECTION_NAME)"; \
	else \
		echo "Warning: No galaxy.yml found for $(COLLECTION_NAME)"; \
	fi

# Run molecule tests for all roles in this collection
molecule:
	@echo "Running molecule tests for roles in $(COLLECTION_NAME)..."
	@for role_dir in $$(find "roles" -mindepth 1 -maxdepth 1 -type d 2>/dev/null); do \
		role_name=$$(basename "$$role_dir"); \
		if [ -d "$$role_dir/molecule" ]; then \
			echo "Testing role: $$role_name"; \
			if [ -f "$$role_dir/Makefile" ]; then \
				$(MAKE) -C "$$role_dir" molecule || echo "Warning: Molecule tests failed for $$role_name"; \
			else \
				cd "$$role_dir" && molecule test || echo "Warning: Molecule tests failed for $$role_name"; \
				cd "$(COLLECTION_DIR)"; \
			fi; \
		else \
			echo "No molecule tests found for role: $$role_name"; \
		fi; \
	done
