# ====================================================================
# Shared Makefile for Ansible Galaxy Collections
# This file provides common targets and variables for all collections
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

# ====================================================================
# Phony Targets
# ====================================================================

.PHONY: help build clean test lint format docs version status \
        lint-make lint-make-checkmake lint-make-bake lint-yaml lint-ansible \
        install install-src install-build install-repo install-beta install-prod

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m$(NAMESPACE).$(COLLECTION_NAME) - Available Targets\033[0m"
	@echo "================================================="
	@echo "\n\033[1mBuild Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 ~ /build|clean|archive/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mTest & Lint Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 ~ /test|lint/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mInstallation Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 ~ /install/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mUtility Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 ~ /docs|format|version|status|help/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# ====================================================================
# Build Targets
# ====================================================================

build: ## Build the collection
	@echo "Building $(NAMESPACE).$(COLLECTION_NAME)..."
	ansible-galaxy collection build --output-path $(DIST_DIR) --force

clean: ## Remove generated files
	@echo "Cleaning $(NAMESPACE).$(COLLECTION_NAME)..."
	rm -f $(DIST_DIR)/$(NAMESPACE)-$(COLLECTION_NAME)-*.tar.gz
	test -d "$(DIST_DIR)" && rmdir -p "$(DIST_DIR)" 2>/dev/null || true

archive: clean build ## Create a clean build archive

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
	@echo "Linting YAML files in $(NAMESPACE).$(COLLECTION_NAME)..."
	@if command -v yamllint >/dev/null 2>&1; then \
		yamllint .; \
	else \
		echo "yamllint not installed. Install with: pip install yamllint"; \
		exit 1; \
	fi

lint-ansible: ## Lint Ansible content
	@echo "Linting Ansible content in $(NAMESPACE).$(COLLECTION_NAME)..."
	@if command -v ansible-lint >/dev/null 2>&1; then \
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
# Documentation
# ====================================================================

docs: ## Generate documentation
	@echo "Generating documentation for $(NAMESPACE).$(COLLECTION_NAME)..."
	@echo "Error: Documentation generation not implemented for this collection"
	@echo "       Please implement the 'docs' target in the collection's Makefile"
	@exit 1

# ====================================================================
# Version and Status
# ====================================================================

version: ## Display the collection version
	@echo "$(NAMESPACE).$(COLLECTION_NAME) version: $(shell grep '^version:' galaxy.yml | awk '{print $$2}')"

status: ## Show the collection status
	@echo "Collection: $(NAMESPACE).$(COLLECTION_NAME)"
	@echo "Version: $(shell grep '^version:' galaxy.yml | awk '{print $$2}')"
	@echo "Location: $(shell pwd)"

# ====================================================================
# Formatting
# ====================================================================

format: ## Format code
	@echo "Formatting code for $(NAMESPACE).$(COLLECTION_NAME)..."
	@echo "Error: Code formatting not implemented for this collection"
	@echo "       Please implement the 'format' target in the collection's Makefile"
	@exit 1

# ====================================================================
# Installation
# ====================================================================

install: ## Install the collection
	@echo "Installing $(NAMESPACE).$(COLLECTION_NAME)..."
	ansible-galaxy collection install $(DIST_DIR)/$(NAMESPACE)-$(COLLECTION_NAME)-*.tar.gz --force

install-src: ## Install collection from source
	ansible-galaxy collection install -f $(COLLECTION_DIR)

install-build: build install ## Build and install the collection

install-repo: ## Install from repository
	ansible-galaxy collection install -f git+https://github.com/$(GITHUB_REPO).git,$(VERSION)

install-beta: ## Install beta version
	$(MAKE) VERSION=devel install-repo

install-prod: ## Install production version
	$(MAKE) VERSION=master install-repo

# ====================================================================
# Default target
# ====================================================================

.DEFAULT_GOAL := help
