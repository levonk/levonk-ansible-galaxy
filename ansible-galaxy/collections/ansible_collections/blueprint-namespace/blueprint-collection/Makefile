# Collection-level Makefile for blueprint-collection
# Handles building and installing the collection

.PHONY: all build test lint lint-ansible lint-yaml lint-markdown install install-src install-build install-repo install-beta install-prod clean archive format docs version status help usage

# Include common variables
include ../../../../../common.mk

# Collection-specific variables
COLLECTION_NAME := $(notdir $(CURDIR))
NAMESPACE_NAME := $(notdir $(shell dirname $(CURDIR)))
COLLECTION_DIR := $(CURDIR)
NAMESPACE_DIR := $(shell dirname $(CURDIR))
DIST_DIR := $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(CURDIR)))))))/../dist

# Default goal
.DEFAULT_GOAL := help

# Default target
all: build ## Build the entire collection (alias for build)

# Build this collection
build: help ## Build the collection
	@echo "Building collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@ansible-galaxy collection build --output-path $(DIST_DIR) --force
	@echo "Build complete. Collection archive in $(DIST_DIR)"

# Test this collection
test: lint ## Run tests on the collection
	@echo "Testing collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@for role in $$(find roles -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sort); do \
		echo "\n=== Testing role $$(basename $$role) ==="; \
		$(MAKE) -C $$role test || echo "Warning: Tests failed for role $$(basename $$role)"; \
	done

# Lint this collection
lint: lint-ansible lint-yaml lint-markdown ## Run all linting tools
	@echo "All linting completed for collection $(NAMESPACE_NAME).$(COLLECTION_NAME)"
	@for role in $$(find roles -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sort); do \
		echo "\n=== Linting role $$(basename $$role) ==="; \
		$(MAKE) -C $$role lint || echo "Warning: Linting failed for role $$(basename $$role)"; \
	done

# Ansible linting
lint-ansible: ## Run ansible-lint
	@echo "Running ansible-lint on collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@ansible-lint $(ANSIBLE_LINT_FLAGS) . || echo "Warning: ansible-lint found issues in collection $(COLLECTION_NAME)"

# YAML linting
lint-yaml: ## Run yamllint
	@echo "Running yamllint on collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@yamllint $(YAMLLINT_FLAGS) . || echo "Warning: yamllint found issues in collection $(COLLECTION_NAME)"

# Markdown linting
lint-markdown: ## Run markdownlint
	@echo "Running markdownlint on collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@find . -name "*.md" -exec markdownlint $(MARKDOWNLINT_FLAGS) {} \; || echo "Warning: markdownlint found issues in collection $(COLLECTION_NAME)"

# Install targets

# Install from source directory
install-src: ## Install collection from source
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
install-build: build ## Install collection from build artifact
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
install-repo: ## Install collection from git repository
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
install-beta: ## Install collection from beta server
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
install-prod: ## Install collection from production server
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
install: install-src ## Install collection (alias for install-src)

# Clean target
clean: ## Remove generated files
	@echo "Cleaning collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -delete
	@rm -rf .pytest_cache

# Archive target
archive: build ## Create an archive of the collection
	@echo "Archive created in $(DIST_DIR)"

# Format target
format: ## Format code according to standards
	@echo "Formatting collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@find . -name "*.yml" -o -name "*.yaml" | xargs yamlfmt -w || echo "Warning: yamlfmt not installed or failed"

# Documentation target
docs: ## Generate documentation
	@echo "Generating documentation for collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@if [ -f "$(BIN_DIR)/generate-docs.sh" ]; then \
		$(BIN_DIR)/generate-docs.sh $(COLLECTION_DIR); \
	else \
		echo "Documentation generator script not found"; \
	fi

# Version target
version: ## Display the collection version
	@grep -oP 'version:\s*\K[0-9.]+' galaxy.yml

# Status target
status: ## Show the collection status
	@echo "Collection: $(NAMESPACE_NAME).$(COLLECTION_NAME)"
	@echo "Version: $$(grep -oP 'version:\s*\K[0-9.]+' galaxy.yml)"
	@echo "Location: $(COLLECTION_DIR)"

# Help target
help: ## Show this help message
	@echo "Ansible Collection: $(NAMESPACE_NAME).$(COLLECTION_NAME)"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Alias for help
usage: help ## Show help message (alias for help)
