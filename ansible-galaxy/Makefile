# ====================================================================
# Project Configuration
# ====================================================================

PROJECT_NAME := levonk-ansible-galaxy
BIN_DIR := $(shell pwd)/../bin
VERSION := $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")
ROOT_DIR := $(shell pwd)
DIST_DIR := $(ROOT_DIR)/../dist
COLLECTIONS_DIR := $(ROOT_DIR)/collections/ansible_collections/levonk

# Include common variables and functions
include common.mk

# ====================================================================
# Path Configuration
# ====================================================================

# Update COLLECTIONS_DIR to use the full path to the levonk namespace
COLLECTIONS_DIR := $(shell pwd)/collections/ansible_collections/levonk

# ====================================================================
# Phony Targets
# ====================================================================

.PHONY: help all clean build test lint format docs version status watch env sync \
        install uninstall deploy release new-module check coverage list \
        lint-make lint-make-checkmake lint-make-bake lint-ansible lint-yaml lint-markdown \
        deploy-dev deploy-prod

# ====================================================================
# Help Target
# ====================================================================

# Default target when running make in this directory
.PHONY: default
.DEFAULT_GOAL := help

help: ## Show this help message
	@echo "\n\033[1m$(PROJECT_NAME) - Available Targets\033[0m"
	@echo "================================================="
	@echo "\n\033[1mBuild Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 !~ /list/ && $$1 !~ /default/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\nRun 'make' in the project root for additional targets including 'list'."

# ====================================================================
# Build Targets
# ====================================================================

# Default build target
.PHONY: all
all: build ## Build all collections

# Main build target
.PHONY: build
build: ## Build all collections
	@echo "Building all collections..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Building collection: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) build) || exit 1; \
	done

clean: ## Remove all generated files
	@echo "Cleaning all collections..."
	@rm -rf $(DIST_DIR)/*.tar.gz
	@for collection in $(COLLECTIONS); do \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) clean) || exit 1; \
	done

# ====================================================================
# Linting Targets
# ====================================================================

lint: lint-make lint-yaml lint-ansible ## Run all linters on all collections

lint-make: ## Run Makefile linters on all collections
	@echo "Running Makefile linters..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Linting Makefiles in: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) lint-make) || exit 1; \
	done

lint-make-checkmake: ## Run checkmake on all Makefiles
	@echo "Running checkmake on all Makefiles..."
	@find . -name 'Makefile' -o -name '*.mk' | xargs -n1 checkmake

lint-make-bake: ## Run bake on all Makefiles
	@echo "Running bake on all Makefiles..."
	@find . -name 'Makefile' -o -name '*.mk' | xargs -n1 bake check

lint-yaml: ## Run yamllint on all YAML files
	@echo "Running yamllint..."
	yamllint .

lint-ansible: ## Run ansible-lint on all Ansible content
	@echo "Running ansible-lint..."
	ansible-lint .

# ====================================================================
# Testing Targets
# ====================================================================

test: ## Run tests for all collections
	@echo "Running tests for all collections..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Testing collection: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) test) || exit 1; \
	done

coverage: ## Generate coverage reports
	@echo "Generating coverage reports..."
	# Add coverage reporting commands here

# ====================================================================
# Documentation
# ====================================================================

docs: ## Generate documentation for all collections
	@echo "Generating documentation..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Generating docs for: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) docs) || exit 1; \
	done

# ====================================================================
# Version and Status
# ====================================================================

version: ## Display version information
	@echo "$(PROJECT_NAME) version: $(VERSION)"

status: ## Show project status
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Collections: $(COLLECTIONS)"
	@echo "Root Directory: $(ROOT_DIR)"

# ====================================================================
# Formatting
# ====================================================================

format: ## Format code according to standards
	@echo "Formatting code..."
	# Add code formatting commands here

# ====================================================================
# Installation
# ====================================================================

install: build ## Install all collections
	@echo "Installing all collections..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing collection: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) install) || exit 1; \
	done

uninstall: ## Uninstall all collections
	@echo "Uninstalling all collections..."
	ansible-galaxy collection remove levonk.*

# ====================================================================
# Deployment
# ====================================================================

deploy: deploy-dev ## Deploy to development environment (default)

deploy-dev: build ## Deploy to development environment
	@echo "Deploying to development environment..."
	# Add deployment commands here

deploy-prod: check_prod_branch check_galaxy_token build ## Deploy to production environment
	@echo "Deploying to production environment..."
	# Add production deployment commands here

# ====================================================================
# Release Management
# ====================================================================

release: ## Create a new release
	@echo "Creating a new release..."
	# Add release process commands here

# ====================================================================
# Development
# ====================================================================

# List target is handled by the root Makefile

watch: ## Watch for file changes and rebuild
	@echo "Watching for file changes..."
	# Add file watching commands here

env: ## Set up development environment
	@echo "Setting up development environment..."
	# Add environment setup commands here

sync: ## Sync with remote repository
	@echo "Syncing with remote repository..."
	git pull --rebase

new-module: ## Create a new module
	@echo "Creating a new module..."
	# Add module creation commands here

# ====================================================================
# Include additional targets
# ====================================================================

# Include additional targets from Makefile.targets if it exists
-include Makefile.targets
