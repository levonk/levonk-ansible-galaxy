# ====================================================================
# Shared Makefile for Ansible Galaxy Collections
# ====================================================================

# Include common variables and functions
# Calculate the path to the ansible-galaxy directory
ANSIBLE_GALAXY_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include $(ANSIBLE_GALAXY_DIR)/common.mk

# Collection-specific variables
COLLECTION_NAME := $(notdir $(shell pwd))
NAMESPACE := $(notdir $(shell dirname $(shell pwd)))
COLLECTION_DIR := $(shell pwd)
DIST_DIR ?= $(ROOT_DIR)/../../../dist

# Default target
default: help

# ====================================================================
# Phony Targets
# ====================================================================

.PHONY: help clean build test lint format docs version status

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m$(NAMESPACE).$(COLLECTION_NAME) - Available Targets\033[0m"
	@echo "================================================="
	@echo "\n\033[1mBuild Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# ====================================================================
# Build Targets
# ====================================================================

build: ## Build the collection
	@echo "Building $(NAMESPACE).$(COLLECTION_NAME)..."
	ansible-galaxy collection build --output-path $(DIST_DIR) --force

clean: ## Remove generated files
	@echo "Cleaning $(NAMESPACE).$(COLLECTION_NAME)..."
	rm -f $(DIST_DIR)/$(NAMESPACE)-$(COLLECTION_NAME)-*.tar.gz

# ====================================================================
# Linting Targets
# ====================================================================

lint: lint-make lint-yaml lint-ansible ## Run all linters

lint-make: lint-make-checkmake lint-make-bake ## Run all Makefile linters

lint-make-checkmake: ## Run checkmake on Makefiles
	@if command -v checkmake >/dev/null 2>&1; then \
		echo "Running checkmake on $(NAMESPACE).$(COLLECTION_NAME)..."; \
		find . -name 'Makefile' -o -name '*.mk' | xargs -n1 checkmake || true; \
	else \
		echo "checkmake not installed. Skipping checkmake linting."; \
		echo "Install with: go install github.com/checkmake/parser@latest && go install github.com/checkmake/checkmake@latest"; \
		true; \
	fi

lint-make-bake: ## Run bake on Makefiles
	@if command -v bake >/dev/null 2>&1; then \
		echo "Running bake on $(NAMESPACE).$(COLLECTION_NAME)..."; \
		find . -name 'Makefile' -o -name '*.mk' | xargs -n1 bake check || true; \
	else \
		echo "bake not installed. Skipping bake linting."; \
		echo "Install with: go install github.com/EbodShojaei/bake@latest"; \
		true; \
	fi

lint-yaml: ## Lint YAML files
	@if command -v yamllint >/dev/null 2>&1; then \
		echo "Running yamllint on $(NAMESPACE).$(COLLECTION_NAME)..."; \
		yamllint .; \
	else \
		echo "yamllint not installed. Install with: pip install yamllint"; \
		exit 1; \
	fi

lint-ansible: ## Lint Ansible content
	@if command -v ansible-lint >/dev/null 2>&1; then \
		echo "Running ansible-lint on $(NAMESPACE).$(COLLECTION_NAME)..."; \
		ansible-lint .; \
	else \
		echo "ansible-lint not installed. Install with: pip install ansible-lint"; \
		exit 1; \
	fi

# ====================================================================
# Testing Targets
# ====================================================================

test: ## Run tests
	@echo "Running tests for $(NAMESPACE).$(COLLECTION_NAME)..."
	ansible-test sanity

# ====================================================================
# Documentation Targets
# ====================================================================

docs: ## Generate documentation
	@echo "Generating documentation for $(NAMESPACE).$(COLLECTION_NAME)..."
	# Add documentation generation commands here

# ====================================================================
# Version and Status
# ====================================================================

version: ## Display the collection version
	@echo "$(NAMESPACE).$(COLLECTION_NAME) version: $(shell grep '^version:' galaxy.yml | awk '{print $$2}')"

status: ## Show the collection status
	@echo "Collection: $(NAMESPACE).$(COLLECTION_NAME)"
	@echo "Version: $(shell grep '^version:' galaxy.yml | awk '{print $$2}')"
	@echo "Location: $(COLLECTION_DIR)"

# ====================================================================
# Formatting
# ====================================================================

format: ## Format code
	@echo "Formatting code for $(NAMESPACE).$(COLLECTION_NAME)..."
	# Add code formatting commands here

# ====================================================================
# Installation
# ====================================================================

install: ## Install the collection
	@echo "Installing $(NAMESPACE).$(COLLECTION_NAME)..."
	ansible-galaxy collection install $(DIST_DIR)/$(NAMESPACE)-$(COLLECTION_NAME)-*.tar.gz --force

# ====================================================================
# Default target
# ====================================================================

.DEFAULT_GOAL := help
