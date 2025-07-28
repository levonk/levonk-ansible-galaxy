# Collection-level Makefile for blueprint-collection
# Handles building and installing the collection

.PHONY: all build test lint install install-src install-build install-repo install-beta install-prod

# Include common variables
include ../../../../../common.mk

# Collection-specific variables
COLLECTION_NAME := $(notdir $(CURDIR))
NAMESPACE_NAME := $(notdir $(shell dirname $(CURDIR)))
COLLECTION_DIR := $(CURDIR)
NAMESPACE_DIR := $(shell dirname $(CURDIR))
DIST_DIR := $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(CURDIR)))))))/../dist

# Default target
all: build

# Build this collection
build:
	@echo "Building collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@ansible-galaxy collection build --output-path $(DIST_DIR) --force
	@echo "Build complete. Collection archive in $(DIST_DIR)"

# Test this collection
test: lint
	@echo "Testing collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@for role in $$(find roles -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sort); do \
		echo "\n=== Testing role $$(basename $$role) ==="; \
		$(MAKE) -C $$role test || echo "Warning: Tests failed for role $$(basename $$role)"; \
	done

# Lint this collection
lint:
	@echo "Linting collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@ansible-lint $(ANSIBLE_LINT_FLAGS) . || echo "Warning: ansible-lint found issues in collection $(COLLECTION_NAME)"
	@for role in $$(find roles -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sort); do \
		echo "\n=== Linting role $$(basename $$role) ==="; \
		$(MAKE) -C $$role lint || echo "Warning: Linting failed for role $$(basename $$role)"; \
	done

# Install targets

# Install from source directory
install-src:
	@echo "Installing collection $(NAMESPACE_NAME).$(COLLECTION_NAME) from source..."
	@ansible-galaxy collection install $(COLLECTION_DIR) --force
	@echo "Running test playbook for collection $(NAMESPACE_NAME).$(COLLECTION_NAME) if available..."
	@if [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found for collection"; \
	fi

# Install from built artifact
install-build: build
	@echo "Installing collection $(NAMESPACE_NAME).$(COLLECTION_NAME) from build artifact..."
	@COLLECTION_FILE=$$(find "$(DIST_DIR)" -name "$(NAMESPACE_NAME)-$(COLLECTION_NAME)-*.tar.gz" | sort -V | tail -n 1); \
	if [ -n "$$COLLECTION_FILE" ]; then \
		echo "Installing $$COLLECTION_FILE..."; \
		ansible-galaxy collection install "$$COLLECTION_FILE" --force; \
		if [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
			ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
		elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
			ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
		else \
			echo "No test playbook found for collection"; \
		fi; \
	else \
		echo "No build artifact found for $(NAMESPACE_NAME).$(COLLECTION_NAME)"; \
	fi

# Install from git repository
install-repo:
	@echo "Installing collection $(NAMESPACE_NAME).$(COLLECTION_NAME) from git repository..."
	@read -p "Enter branch name (default: main): " branch; \
	branch=$${branch:-main}; \
	echo "Installing from branch: $$branch"; \
	ansible-galaxy collection install git+https://github.com/levonk/levonk-ansible-galaxy.git#/collections/ansible_collections/$(NAMESPACE_NAME)/$(COLLECTION_NAME)/,$$branch --force; \
	if [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found for collection"; \
	fi

# Install from beta server
install-beta:
	@echo "Installing collection $(NAMESPACE_NAME).$(COLLECTION_NAME) from beta server..."
	@ansible-galaxy collection install $(NAMESPACE_NAME).$(COLLECTION_NAME) --server https://galaxy-dev.ansible.com --force
	@if [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found for collection"; \
	fi

# Install from production server
install-prod:
	@echo "Installing collection $(NAMESPACE_NAME).$(COLLECTION_NAME) from production server..."
	@ansible-galaxy collection install $(NAMESPACE_NAME).$(COLLECTION_NAME) --force
	@if [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found for collection"; \
	fi

# Alias for install-src
install: install-src
