# ====================================================================
# Project Configuration
# ====================================================================

# Include common variables and functions first
include common.mk

# Project-specific overrides can go here
PROJECT_NAME ?= levonk-ansible-galaxy
BIN_DIR ?= $(ROOT_DIR)/../bin
VERSION ?= $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")
DIST_DIR ?= $(ROOT_DIR)/../dist

# ====================================================================
# Phony Targets
# ====================================================================

.PHONY: all clean build test lint format docs version status \
        install uninstall check coverage \
        lint-make lint-make-checkmake lint-make-bake lint-ansible lint-yaml lint-markdown

# ====================================================================
# Default Target
# ====================================================================

.DEFAULT_GOAL := help

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m$(PROJECT_NAME) - Available Targets\033[0m"
	@echo "================================================="
	@echo "\n\033[1mCore Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 !~ /default/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\nRun 'make' in the project root for additional targets including 'list'."

# ====================================================================
# Build Targets
# ====================================================================

# Default build target
all: test ## Run tests for all collections (default)

# Main build target
build: ## Build all collections
	@echo "Building all collections..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Building collection: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) build) || exit 1; \
	done

clean: ## Remove all generated files and caches
	@echo "Cleaning all collections..."
	@# Remove distribution packages
	@rm -rf $(DIST_DIR)/*.tar.gz
	@# Clean each collection
	@for collection in $(COLLECTIONS); do \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) clean) || exit 1; \
	done
	@# Remove .ansible cache directories if they exist
	@if [ -d ".ansible" ] || [ -d "$(COLLECTIONS_DIR)" ] || [ -d "$(ROOT_DIR)/../.ansible" ]; then \
		echo "Removing .ansible cache directories..."; \
		find . -type d -name '.ansible' -exec rm -rf {} + 2>/dev/null || true; \
		find $(COLLECTIONS_DIR) -type d -name '.ansible' -exec rm -rf {} + 2>/dev/null || true; \
		find $(ROOT_DIR)/.. -maxdepth 1 -type d -name '.ansible' -exec rm -rf {} + 2>/dev/null || true; \
	fi

# Alias for clean
distclean: clean ## Alias for clean target

# ====================================================================
# Linting Targets
# ====================================================================

lint: lint-make lint-yaml lint-ansible lint-markdown ## Run all linters on all collections

lint-make: ## Run Makefile linters on all collections
	@echo "Running Makefile linters..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Linting Makefiles in: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) lint-make) || exit 1; \
	done

lint-make-checkmake: ## Run checkmake on all Makefiles
	@if ! command -v checkmake >/dev/null 2>&1; then \
		echo "checkmake not installed. Install with: go install github.com/checkmake/parser@latest && go install github.com/checkmake/checkmake@latest"; \
		exit 1; \
	fi
	@echo "Running checkmake on all Makefiles..."
	@find . -name 'Makefile' -o -name '*.mk' | xargs -n1 checkmake

lint-make-bake: ## Run bake on all Makefiles
	@if ! command -v bake >/dev/null 2>&1; then \
		echo "bake not installed. Install with: go install github.com/EbodShojaei/bake@latest"; \
		exit 1; \
	fi
	@echo "Running bake on all Makefiles..."
	@find . -name 'Makefile' -o -name '*.mk' | xargs -n1 bake check

lint-yaml: ## Run yamllint on all YAML files
	@if ! command -v yamllint >/dev/null 2>&1; then \
		echo "yamllint not installed. Install with: pip install yamllint"; \
		exit 1; \
	fi
	@echo "Running yamllint..."
	yamllint .

lint-ansible: ## Run ansible-lint on all Ansible content
	@if ! command -v ansible-lint >/dev/null 2>&1; then \
		echo "ansible-lint not installed. Install with: pip install ansible-lint"; \
		exit 1; \
	fi
	@echo "Running ansible-lint..."
	ansible-lint .

lint-markdown: ## Run markdownlint on all Markdown files
	@if ! command -v markdownlint >/dev/null 2>&1; then \
		echo "markdownlint not installed. Install with: npm install -g markdownlint-cli"; \
		exit 1; \
	fi
	@echo "Running markdownlint..."
	markdownlint "**/*.md"

# ====================================================================
# Testing Targets
# ====================================================================

test: ## Run tests for all collections
	@echo "Running tests for all collections..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Testing collection: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) test) || exit 1; \
	done

check: test ## Alias for test target

coverage: ## Generate coverage reports
	@echo "Generating coverage reports..."
	@# Add coverage reporting commands here
	@echo "Coverage reporting not yet implemented"

# ====================================================================
# Documentation
# ====================================================================

docs: ## Generate documentation for all collections
	@echo "Generating documentation..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Generating docs for: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) docs) || exit 1; \
	done
	@echo "Documentation generated in docs/ directory"

# ====================================================================
# Version and Status
# ====================================================================

version: ## Display version information
	@echo "$(PROJECT_NAME) version: $(VERSION)"

status: ## Show project status
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Root Directory: $(ROOT_DIR)"
	@echo "Collections Directory: $(COLLECTIONS_DIR)"
	@echo "\nAvailable Collections:"
	@for collection in $(COLLECTIONS); do \
		echo "- $$collection"; \
	done

# ====================================================================
# Formatting
# ====================================================================

format: ## Format code according to standards
	@echo "Formatting code..."
	@# Add code formatting commands here
	@echo "Code formatting not yet implemented"

fmt: format ## Alias for format target

# ====================================================================
# Installation
# ====================================================================

install: build ## Install all collections
	@echo "Installing all collections..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing collection: $$collection ==="; \
		(cd $(COLLECTIONS_DIR)/$$collection && $(MAKE) install) || exit 1; \
	done
	@echo "\nInstallation complete. Collections installed in ~/.ansible/collections/ansible_collections/levonk/"

uninstall: ## Uninstall all collections
	@echo "Uninstalling all collections..."
	@for collection in $(COLLECTIONS); do \
		echo "Uninstalling: levonk.$$collection"; \
		ansible-galaxy collection remove levonk.$$collection || true; \
	done
	@echo "\nUninstallation complete."

# ====================================================================
# Include additional targets from Makefile.targets
# ====================================================================
-include Makefile.targets
