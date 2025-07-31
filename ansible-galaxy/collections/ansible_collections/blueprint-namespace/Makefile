# Namespace-level Makefile for blueprint-namespace
# Handles building and installing all collections in this namespace

.PHONY: all build test lint lint-ansible lint-yaml lint-markdown install install-src install-build install-repo install-beta install-prod clean archive format docs version status help usage

# Include common variables
include ../../../../common.mk

# Namespace-specific variables
NAMESPACE_NAME := $(notdir $(CURDIR))
NAMESPACE_DIR := $(CURDIR)
DIST_DIR := $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(CURDIR)))))/../dist
COLLECTIONS := $(shell find . -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sed 's|^\./||' | sort)

# Default goal
.DEFAULT_GOAL := help

# Default target
all: build ## Build all collections in this namespace (alias for build)

# Build all collections in this namespace
build: help ## Build all collections in this namespace
	@echo "Building all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Building collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection build || echo "Warning: Build failed for collection $$collection"; \
		else \
			cd $$collection && ansible-galaxy collection build --output-path $(DIST_DIR) --force || echo "Warning: Build failed for collection $$collection"; \
		fi; \
	done

# Test all collections in this namespace
test: lint ## Run tests for all collections in this namespace
	@echo "Testing all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Testing collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection test || echo "Warning: Tests failed for collection $$collection"; \
		fi; \
	done

# Lint all collections in this namespace
lint: lint-ansible lint-yaml lint-markdown ## Run all linting tools on all collections
	@echo "Linting all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Linting collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection lint || echo "Warning: Linting failed for collection $$collection"; \
		fi; \
	done

# Install targets

# Ansible linting
lint-ansible: ## Run ansible-lint on all collections
	@echo "Running ansible-lint on all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Running ansible-lint on collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection lint-ansible || echo "Warning: ansible-lint failed for collection $$collection"; \
		else \
			cd $$collection && ansible-lint $(ANSIBLE_LINT_FLAGS) . || echo "Warning: ansible-lint found issues in collection $$collection"; \
		fi; \
	done

# YAML linting
lint-yaml: ## Run yamllint on all collections
	@echo "Running yamllint on all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Running yamllint on collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection lint-yaml || echo "Warning: yamllint failed for collection $$collection"; \
		else \
			cd $$collection && yamllint $(YAMLLINT_FLAGS) . || echo "Warning: yamllint found issues in collection $$collection"; \
		fi; \
	done

# Markdown linting
lint-markdown: ## Run markdownlint on all collections
	@echo "Running markdownlint on all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Running markdownlint on collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection lint-markdown || echo "Warning: markdownlint failed for collection $$collection"; \
		else \
			cd $$collection && find . -name "*.md" -exec markdownlint $(MARKDOWNLINT_FLAGS) {} \; || echo "Warning: markdownlint found issues in collection $$collection"; \
		fi; \
	done

# Install all collections from source directory
install-src: ## Install all collections from source
	@echo "Installing all collections in namespace $(NAMESPACE_NAME) from source..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing collection $(NAMESPACE_NAME).$$collection from source ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection install-src || echo "Warning: Installation failed for collection $$collection"; \
		else \
			ansible-galaxy collection install "$$collection" --force || echo "Warning: Installation failed for collection $$collection"; \
		fi; \
	done
	@if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n=== Running namespace test playbook ==="; \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "\nNo namespace test playbook found"; \
	fi

# Install all collections from built artifacts
install-build: build ## Install all collections from build artifacts
	@echo "Installing all collections in namespace $(NAMESPACE_NAME) from build artifacts..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing collection $(NAMESPACE_NAME).$$collection from build artifact ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection install-build || echo "Warning: Installation failed for collection $$collection"; \
		else \
			COLLECTION_FILE=$$(find "$(DIST_DIR)" -name "$(NAMESPACE_NAME)-$$collection-*.tar.gz" | sort -V | tail -n 1); \
			if [ -n "$$COLLECTION_FILE" ]; then \
				echo "Installing $$COLLECTION_FILE..."; \
				ansible-galaxy collection install "$$COLLECTION_FILE" --force || echo "Warning: Installation failed for collection $$collection"; \
			else \
				echo "No build artifact found for $(NAMESPACE_NAME).$$collection"; \
			fi; \
		fi; \
	done
	@if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n=== Running namespace test playbook ==="; \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "\nNo namespace test playbook found"; \
	fi

# Install all collections from git repository
install-repo: ## Install all collections from git repository
	@echo "Installing all collections in namespace $(NAMESPACE_NAME) from git repository..."
	@read -p "Enter branch name (default: main): " branch; \
	branch=$${branch:-main}; \
	echo "Installing from branch: $$branch"; \
	for collection in $(COLLECTIONS); do \
		echo "\n=== Installing collection $(NAMESPACE_NAME).$$collection from git repository ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection install-repo || echo "Warning: Installation failed for collection $$collection"; \
		else \
			ansible-galaxy collection install git+https://github.com/levonk/levonk-ansible-galaxy.git#/collections/ansible_collections/$(NAMESPACE_NAME)/$$collection/,$$branch --force || echo "Warning: Installation failed for collection $$collection"; \
		fi; \
	done
	@if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n=== Running namespace test playbook ==="; \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "\nNo namespace test playbook found"; \
	fi

# Install all collections from beta server
install-beta: ## Install all collections from beta server
	@echo "Installing all collections in namespace $(NAMESPACE_NAME) from beta server..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing collection $(NAMESPACE_NAME).$$collection from beta server ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection install-beta || echo "Warning: Installation failed for collection $$collection"; \
		else \
			ansible-galaxy collection install $(NAMESPACE_NAME).$$collection --server https://galaxy-dev.ansible.com --force || echo "Warning: Installation failed for collection $$collection"; \
		fi; \
	done
	@if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n=== Running namespace test playbook ==="; \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "\nNo namespace test playbook found"; \
	fi

# Install all collections from production server
install-prod: ## Install all collections from production server
	@echo "Installing all collections in namespace $(NAMESPACE_NAME) from production server..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing collection $(NAMESPACE_NAME).$$collection from production server ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection install-prod || echo "Warning: Installation failed for collection $$collection"; \
		else \
			ansible-galaxy collection install $(NAMESPACE_NAME).$$collection --force || echo "Warning: Installation failed for collection $$collection"; \
		fi; \
	done
	@if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n=== Running namespace test playbook ==="; \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "\nNo namespace test playbook found"; \
	fi

# Alias for install-src
install: install-src ## Install all collections (alias for install-src)

# Clean target
clean: ## Remove generated files from all collections
	@echo "Cleaning all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Cleaning collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection clean || echo "Warning: Cleaning failed for collection $$collection"; \
		else \
			find "$$collection" -name "*.pyc" -delete; \
			find "$$collection" -name "__pycache__" -delete; \
		fi; \
	done

# Archive target
archive: build ## Create archives of all collections
	@echo "Archives created in $(DIST_DIR)"

# Format target
format: ## Format code according to standards in all collections
	@echo "Formatting all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Formatting collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection format || echo "Warning: Formatting failed for collection $$collection"; \
		else \
			find "$$collection" -name "*.yml" -o -name "*.yaml" | xargs yamlfmt -w || echo "Warning: yamlfmt not installed or failed"; \
		fi; \
	done

# Documentation target
docs: ## Generate documentation for all collections
	@echo "Generating documentation for all collections in namespace $(NAMESPACE_NAME)..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Generating documentation for collection $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/Makefile" ]; then \
			$(MAKE) -C $$collection docs || echo "Warning: Documentation generation failed for collection $$collection"; \
		fi; \
	done

# Version target
version: ## Display versions of all collections
	@echo "Versions of collections in namespace $(NAMESPACE_NAME):"
	@for collection in $(COLLECTIONS); do \
		if [ -f "$$collection/galaxy.yml" ]; then \
			echo "$(NAMESPACE_NAME).$$collection: $$(grep -oP 'version:\s*\K[0-9.]+' $$collection/galaxy.yml)"; \
		else \
			echo "$(NAMESPACE_NAME).$$collection: version not found"; \
		fi; \
	done

# Status target
status: ## Show status of all collections
	@echo "Status of collections in namespace $(NAMESPACE_NAME):"
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Collection: $(NAMESPACE_NAME).$$collection ==="; \
		if [ -f "$$collection/galaxy.yml" ]; then \
			echo "Version: $$(grep -oP 'version:\s*\K[0-9.]+' $$collection/galaxy.yml)"; \
		else \
			echo "Version: not found"; \
		fi; \
		echo "Location: $(NAMESPACE_DIR)/$$collection"; \
	done

# Help target
help: ## Show this help message
	@echo "Ansible Namespace: $(NAMESPACE_NAME)"
	@echo "Collections: $(COLLECTIONS)"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Alias for help
usage: help ## Show help message (alias for help)
