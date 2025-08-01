# ====================================================================
# Shared Makefile Targets for Ansible Collections
# This file is included by collection Makefiles to provide common targets
# ====================================================================

# ====================================================================
# Phony Targets
# ====================================================================

.PHONY: help build clean test lint format docs version status

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

lint-make: ## Run Makefile linters
	@echo "Linting Makefiles in $(NAMESPACE).$(COLLECTION_NAME)..."
	@if command -v checkmake >/dev/null 2>&1; then \
		echo "Running checkmake..."; \
		checkmake $(MAKEFILE_LIST) || true; \
	else \
		echo "checkmake not installed. Skipping checkmake linting."; \
		echo "Install with: go install github.com/checkmake/parser@latest && go install github.com/checkmake/checkmake@latest"; \
	fi
	@if command -v bake >/dev/null 2>&1; then \
		echo "Running bake..."; \
		bake check $(MAKEFILE_LIST) || true; \
	else \
		echo "bake not installed. Skipping bake linting."; \
		echo "Install with: go install github.com/EbodShojaei/bake@latest"; \
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
	# Add documentation generation commands here

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
	# Add code formatting commands here

# ====================================================================
# Installation
# ====================================================================

install: build ## Install the collection
	@echo "Installing $(NAMESPACE).$(COLLECTION_NAME)..."
	ansible-galaxy collection install $(DIST_DIR)/$(NAMESPACE)-$(COLLECTION_NAME)-*.tar.gz --force

# ====================================================================
# Default target
# ====================================================================

.DEFAULT_GOAL := help
