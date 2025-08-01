# ====================================================================
# Collection: {{ collection_name }}
# ====================================================================
# Makefile for Ansible collection {{ namespace_name }}.{{ collection_name }}
# ====================================================================

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all build test lint lint-ansible lint-yaml lint-markdown \
        install install-src install-build install-repo install-beta install-prod \
        clean archive format docs version status help usage

# ====================================================================
# Include Common Configuration
# ====================================================================
include ../../../../../common.mk

# ====================================================================
# Collection Configuration
# ====================================================================
COLLECTION_NAME := $(notdir $(CURDIR))
NAMESPACE_NAME := $(notdir $(shell dirname $(CURDIR)))
COLLECTION_DIR := $(CURDIR)
NAMESPACE_DIR := $(shell dirname $(CURDIR))
DIST_DIR := $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(CURDIR)))))))/../dist

# ====================================================================
# Default Target
# ====================================================================
.DEFAULT_GOAL := help

# ====================================================================
# Build Targets
# ====================================================================

all: build ## Build the entire collection (default)

build: ## Build the collection
	@echo "Building collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@ansible-galaxy collection build --output-path $(DIST_DIR) --force
	@echo "Build complete. Collection archive in $(DIST_DIR)"

# ====================================================================
# Test Targets
# ====================================================================

test: lint ## Run all tests in the collection
	@echo "Testing collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@for role in $$(find roles -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sort); do \
		echo "\n=== Testing role $$(basename $$role) ==="; \
		$(MAKE) -C $$role test || echo "Warning: Tests failed for role $$(basename $$role)"; \
	done

# ====================================================================
# Lint Targets
# ====================================================================

lint: lint-ansible lint-yaml lint-markdown ## Run all linting tools
	@echo "All linting completed for collection $(NAMESPACE_NAME).$(COLLECTION_NAME)"
	@for role in $$(find roles -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sort); do \
		echo "\n=== Linting role $$(basename $$role) ==="; \
		$(MAKE) -C $$role lint || echo "Warning: Linting failed for role $$(basename $$role)"; \
	done

lint-ansible: ## Run ansible-lint on the collection
	@echo "Running ansible-lint on collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@ansible-lint $(ANSIBLE_LINT_FLAGS) . || \
		echo "Warning: ansible-lint found issues in collection $(COLLECTION_NAME)"

lint-yaml: ## Run yamllint on YAML files in the collection
	@echo "Running yamllint on collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@find . -name "*.yml" -o -name "*.yaml" | xargs yamllint $(YAMLLINT_FLAGS) || \
		echo "Warning: yamllint found issues in collection $(COLLECTION_NAME)"

lint-markdown: ## Run markdownlint on documentation
	@echo "Running markdownlint on collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@find . -name "*.md" -exec markdownlint $(MARKDOWNLINT_FLAGS) {} \; || \
		echo "Warning: markdownlint found issues in collection $(COLLECTION_NAME)"

# Install targets

# ====================================================================
# Installation Targets
# ====================================================================

install-src: ## Install collection from source directory
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

install: install-src ## Install collection (alias for install-src)

# ====================================================================
# Utility Targets
# ====================================================================

clean: ## Remove generated files
	@echo "Cleaning collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -delete
	@rm -rf .pytest_cache
	@rm -rf $(DIST_DIR)/$(NAMESPACE_NAME)-$(COLLECTION_NAME)-*.tar.gz
	@echo "Cleaned build artifacts and temporary files"

archive: build ## Create an archive of the collection
	@echo "Archive created at $(DIST_DIR)/$(NAMESPACE_NAME)-$(COLLECTION_NAME)-$(shell date +%Y%m%d).tar.gz"

format: ## Format code according to standards
	@echo "Formatting collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@find . -name "*.yml" -o -name "*.yaml" | xargs yamlfmt -w || \
		echo "Warning: yamlfmt not installed or failed"

docs: ## Generate documentation
	@echo "Generating documentation for collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@if [ -f "$(BIN_DIR)/generate-docs.sh" ]; then \
		$(BIN_DIR)/generate-docs.sh $(COLLECTION_DIR); \
	else \
		echo "Documentation generator script not found"; \
	fi

version: ## Display the collection version
	@echo "$(NAMESPACE_NAME).$(COLLECTION_NAME) version: $$(grep -oP 'version:\s*\K[0-9.]+' galaxy.yml)"

status: ## Show the collection status
	@echo "=== Collection: $(NAMESPACE_NAME).$(COLLECTION_NAME) ==="
	@echo "Version: $$(grep -oP 'version:\s*\K[0-9.]+' galaxy.yml)"
	@echo "Location: $(COLLECTION_DIR)"
	@echo "Roles: $$(find roles -mindepth 1 -maxdepth 1 -type d -not -path \"*/\\.*\" | wc -l) found"
	@echo "Last modified: $$(date -r galaxy.yml)"

# ====================================================================
# Watch and Development Targets
# ====================================================================

watch: ## Watch for changes and run tests
	@echo "Watching for changes in collection $(NAMESPACE_NAME).$(COLLECTION_NAME)..."
	@while true; do \
		inotifywait -qre modify .; \
		echo "\n=== Detected changes, running tests... ===\n"; \
		make test; \
	done

new-role: ## Create a new role in this collection
	@read -p "Enter role name: " role_name; \
	if [ -z "$$role_name" ]; then \
		echo "Error: Role name cannot be empty"; \
		exit 1; \
	fi; \
	mkdir -p "roles/$$role_name"; \
	echo "Created new role: roles/$$role_name"; \
	# Initialize role structure
	cd "roles/$$role_name" && ansible-galaxy role init $$role_name

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m$(NAMESPACE_NAME).$(COLLECTION_NAME) - Available Targets\033[0m"
	@echo "================================================="
	@echo "\n\033[1mBuild Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 ~ /build|test|lint|install/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mUtility Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 ~ /clean|format|docs|version|status|watch|new-role/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mHelp Target:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 ~ /help|usage/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

usage: help ## Show help message (alias for help)
