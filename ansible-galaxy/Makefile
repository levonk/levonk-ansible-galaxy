# ====================================================================
# Ansible Galaxy Collection Makefile
# This file provides targets for managing Ansible Galaxy collections
# ====================================================================

# Include common variables and functions
# Include common variables and settings
include $(dir $(realpath $(lastword $(MAKEFILE_LIST))))/common.mk

# Include additional targets (if not already included)
ifndef MAKEFILE_TARGETS_INCLUDED
include Makefile.targets
endif

# ====================================================================
# Project Configuration
# ====================================================================
PROJECT_NAME ?= levonk-ansible-galaxy
# These are already defined in common.mk, but we can override them here if needed
# BIN_DIR ?= $(ROOT_DIR)/bin
# DIST_DIR ?= $(ROOT_DIR)/dist
# BUILD_DIR ?= $(ROOT_DIR)/build
# DOCS_DIR ?= $(ROOT_DIR)/docs
# TESTS_DIR ?= $(ROOT_DIR)/tests
VERSION ?= $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")

# Default namespace for collections
NAMESPACE ?= levonk

# Detect all collections if not specified
COLLECTIONS ?= $(notdir $(wildcard $(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)/*))

# ====================================================================
# Collection-specific Targets (when COLLECTION is set)
# ====================================================================
ifdef COLLECTION
    COLLECTIONS := $(COLLECTION)
    COLLECTION_DIR := $(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)/$(COLLECTION)
    COLLECTION_DIST := $(DIST_DIR)/$(NAMESPACE)-$(COLLECTION)-*.tar.gz
    
    # Override help target for collection context
    .PHONY: help
    help:
	@echo "\n\033[1m$(NAMESPACE).$(COLLECTION) - Collection Targets\033[0m"
	@echo "================================================="
	@echo "\n\033[1mBuild and Test:\033[0m"
	@echo "  \033[36mmake build\033[0m           - Build the collection"
	@echo "  \033[36mmake test\033[0m            - Run tests"
	@echo "  \033[36mmake lint\033[0m            - Run linters"
	@echo "  \033[36mmake format\033[0m          - Format source files"
	@echo "  \033[36mmake clean\033[0m           - Remove build artifacts"
	@echo ""
	@echo "\033[1mInstallation:\033[0m"
	@echo "  \033[36mmake install-beta\033[0m    - Install from beta server"
	@echo "  \033[36mmake install-prod\033[0m    - Install from production"
	@echo "  \033[36mmake install-src\033[0m     - Install from source"
	@echo ""
	@echo "\033[1mPublishing:\033[0m"
	@echo "  \033[36mmake publish-beta\033[0m    - Publish to beta server"
	@echo "  \033[36mmake publish-prod\033[0m    - Publish to production"
	@echo ""
	@echo "\033[1mFor more information:\033[0m"
	@echo "  • Run 'make <target> --help' for target-specific help"
	@echo "  • Check the README.md for detailed documentation"
	@echo "  • Review the Makefile for additional targets"
	@echo ""
	@echo "Run 'make help' in the top-level directory for all available targets."
endif

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help build clean format lint test check docs version status \
        install uninstall coverage setup check-env check-tools \
        publish-beta publish-prod install-beta install-prod install-src \
        lint-make lint-ansible lint-yaml lint-markdown \
        new-collection new-role debug list-collections

# ====================================================================
# Default Target
# ====================================================================

.DEFAULT_GOAL := help

# ====================================================================
# Help and Documentation
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m$(PROJECT_NAME) - Ansible Galaxy Collections\033[0m"
	@echo "================================================="
	@echo "\n\033[1mProject Information:\033[0m"
	@echo "  • Version: $(VERSION)"
	@echo "  • Namespace: $(NAMESPACE)"
	@echo "  • Collections: $(words $(COLLECTIONS)) found"

	@echo "\n\033[1mCore Targets:\033[0m"
	@echo "  make all              Build, lint, and test all collections (default)"
	@echo "  make build            Build all collections"
	@echo "  make test             Run tests for all collections"
	@echo "  make lint             Run all linters"
	@echo "  make format           Format all source files"
	@echo "  make clean            Remove build artifacts"

	@echo "\n\033[1mDevelopment:\033[0m"
	@echo "  make check-env        Check development environment"
	@echo "  make check-tools      Verify required tools are installed"
	@echo "  make docs             Generate documentation"
	@echo "  make version          Show version information"
	@echo "  make status           Show project status"

	@echo "\n\033[1mPublishing:\033[0m"
	@echo "  make publish-beta     Publish to beta channel"
	@echo "  make publish-prod     Publish to production"

	@echo "\n\033[1mCollection Management:\033[0m"
	@echo "  make list-collections List all available collections"
	@echo "  make new-collection   Create a new collection"
	@echo "  make new-role         Create a new role in a collection"

	@echo "\n\033[1mFor more information:\033[0m"
	@echo "  • Run 'make <target> --help' for target-specific help"
	@echo "  • Check the README.md for detailed documentation"
	@echo "  • Review the Makefile for additional targets"

# ====================================================================
# Build Targets
# ====================================================================

# Default build target
all: build lint test

# Main build target (requires ANSIBLE_GALAXY_TOKEN)
build: ## Build all collections (requires ANSIBLE_GALAXY_TOKEN)
	@echo "\n\033[1mBuilding Collections\033[0m"
	@echo "=================="
	@if [ -z "$(COLLECTIONS)" ]; then \
		echo "\033[1;33mNo collections found in $(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)/\033[0m"; \
		exit 0; \
	fi
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		COLLECTION_DIR="$(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)/$$collection"; \
		if [ -d "$$COLLECTION_DIR" ]; then \
			echo "\n\033[1m• Building: $(NAMESPACE).$$collection\033[0m"; \
			if ! (cd "$$COLLECTION_DIR" && $(MAKE) build); then \
				echo "\033[1;31m✗ Build failed: $(NAMESPACE).$$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			else \
				echo "\033[1;32m✓ Built: $(NAMESPACE).$$collection\033[0m"; \
			fi; \
		else \
			echo "\033[1;33m• Skipping (not a directory): $$COLLECTION_DIR\033[0m"; \
		fi; \
	done; \
	if [ "$$FAILED" -gt 0 ]; then \
		echo "\n\033[1;31m✗ Build completed with $$FAILED failure(s)\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32m✓ All collections built successfully\033[0m"; \
	fi

clean: ## Remove all generated files and caches
	@echo "\n\033[1mCleaning Project\033[0m"
	@echo "==============="
	@# Remove distribution packages
	@if [ -d "$(DIST_DIR)" ]; then \
		echo "• Removing distribution files: $(DIST_DIR)/*.tar.gz"; \
		rm -f "$(DIST_DIR)"/*.tar.gz 2>/dev/null || true; \
	fi
	@# Clean each collection
	@if [ -n "$(COLLECTIONS)" ]; then \
		for collection in $(COLLECTIONS); do \
			COLLECTION_DIR="$(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)/$$collection"; \
			if [ -d "$$COLLECTION_DIR" ]; then \
				echo "• Cleaning: $(NAMESPACE).$$collection"; \
				(cd "$$COLLECTION_DIR" && $(MAKE) clean) || true; \
			fi; \
		done; \
	fi
	@# Remove cache directories
	@echo "• Cleaning cache directories..."; \
	for dir in "." "$(COLLECTIONS_DIR)" "$(ROOT_DIR)/.."; do \
		if [ -d "$$dir" ]; then \
			find "$$dir" -type d -name '.ansible' -prune -exec rm -rf {} + 2>/dev/null || true; \
			find "$$dir" -type d -name '__pycache__' -prune -exec rm -rf {} + 2>/dev/null || true; \
			find "$$dir" -type d -name '.pytest_cache' -prune -exec rm -rf {} + 2>/dev/null || true; \
		fi; \
	done
	@# Remove build directory
	@if [ -d "$(BUILD_DIR)" ]; then \
		echo "• Removing build directory: $(BUILD_DIR)"; \
		rm -rf "$(BUILD_DIR)"; \
	fi
	@echo "\n\033[1;32m✓ Clean complete\033[0m"

# Alias for clean
distclean: clean ## Alias for clean target

# ====================================================================
# Linting and Formatting
# ====================================================================

lint: lint-make lint-yaml lint-ansible lint-markdown ## Run all linters on all collections

format: ## Format all source files
	@echo "\n\033[1mFormatting Source Files\033[0m"
	@echo "======================"
	@if command -v yamlfmt >/dev/null 2>&1; then \
		echo "• Formatting YAML files"; \
		find . -name "*.yml" -o -name "*.yaml" | xargs -r yamlfmt -w; \
	else \
		echo "\033[1;33m• yamlfmt not found, skipping YAML formatting\033[0m"; \
	fi

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
	@echo "\n\033[1mRunning Tests\033[0m"
	@echo "============"
	@if [ -z "$(COLLECTIONS)" ]; then \
		echo "\033[1;33mNo collections found to test\033[0m"; \
		exit 0; \
	fi
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		COLLECTION_DIR="$(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)/$$collection"; \
		if [ -d "$$COLLECTION_DIR" ]; then \
			echo "\n\033[1m• Testing: $(NAMESPACE).$$collection\033[0m"; \
			if ! (cd "$$COLLECTION_DIR" && $(MAKE) test); then \
				echo "\033[1;31m✗ Tests failed: $(NAMESPACE).$$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			else \
				echo "\033[1;32m✓ Tests passed: $(NAMESPACE).$$collection\033[0m"; \
			fi; \
		fi; \
	done; \
	if [ "$$FAILED" -gt 0 ]; then \
		echo "\n\033[1;31m✗ Testing completed with $$FAILED failure(s)\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32m✓ All tests passed\033[0m"; \
	fi

check: test ## Alias for test target

coverage: ## Generate coverage reports
	@echo "Generating coverage reports..."
	@# Add coverage reporting commands here
	@echo "Coverage reporting not yet implemented"

# ====================================================================
# Documentation
# ====================================================================

docs: ## Generate documentation for all collections
	@echo "\n\033[1mGenerating Documentation\033[0m"
	@echo "======================"
	@if [ -z "$(COLLECTIONS)" ]; then \
		echo "\033[1;33mNo collections found to document\033[0m"; \
		exit 0; \
	fi
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		COLLECTION_DIR="$(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)/$$collection"; \
		if [ -d "$$COLLECTION_DIR" ]; then \
			echo "\n\033[1m• Documenting: $(NAMESPACE).$$collection\033[0m"; \
			if ! (cd "$$COLLECTION_DIR" && $(MAKE) docs); then \
				echo "\033[1;31m✗ Documentation failed: $(NAMESPACE).$$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			else \
				echo "\033[1;32m✓ Documentation generated: $(NAMESPACE).$$collection\033[0m"; \n			fi; \
		fi; \
	done; \
	if [ "$$FAILED" -gt 0 ]; then \
		echo "\n\033[1;31m✗ Documentation generation completed with $$FAILED failure(s)\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32m✓ Documentation generated successfully in $(DOCS_DIR)\033[0m"; \
	fi

# ====================================================================
# Environment and Tools
# ====================================================================

check-env: ## Check development environment setup
	@echo "\n\033[1mChecking Development Environment\033[0m"
	@echo "================================"
	@echo "• Project: $(PROJECT_NAME)"
	@echo "• Version: $(VERSION)"
	@echo "• Path: $(shell pwd)"
	@echo "• Python: $(shell python3 --version 2>/dev/null || echo 'Not found')"
	@echo "• Pip: $(shell pip3 --version 2>/dev/null || echo 'Not found')"
	@echo "• Ansible: $(shell ansible --version 2>/dev/null | head -n 1 || echo 'Not found')"
	@echo ""
	@echo "\033[1mDirectories:\033[0m"
	@echo "• Bin: $(BIN_DIR) $(shell [ -d "$(BIN_DIR)" ] && echo '✓' || echo '✗ (Missing)')"
	@echo "• Dist: $(DIST_DIR) $(shell [ -d "$(DIST_DIR)" ] && echo '✓' || echo '✗ (Missing)')"
	@echo "• Docs: $(DOCS_DIR) $(shell [ -d "$(DOCS_DIR)" ] && echo '✓' || echo '✗ (Missing)')"
	@echo "• Tests: $(TESTS_DIR) $(shell [ -d "$(TESTS_DIR)" ] && echo '✓' || echo '✗ (Missing)')"

check-tools: ## Check for required development tools
	@echo "\n\033[1mChecking Required Tools\033[0m"
	@echo "======================"
	@FAILED=0; \
	for tool in make git ansible python3 pip3; do \
		if command -v $$tool >/dev/null 2>&1; then \
			VERSION=$$($$tool --version 2>/dev/null | head -n 1 | cut -d' ' -f2-); \
			echo "\033[1;32m✓ $$tool\033[0m: $${VERSION:-(version not found)}"; \
		else \
			echo "\033[1;31m✗ $$tool not found\033[0m"; \
			FAILED=1; \
		fi; \
	done; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31mError: Some required tools are missing\033[0m"; \
		exit 1; \
	fi

# ====================================================================
# Version and Status
# ====================================================================

version: ## Display version information
	@echo "\n\033[1m$(PROJECT_NAME) Version Information\033[0m"
	@echo "================================"
	@echo "• Version: $(VERSION)"
	@echo "• Git Revision: $(shell git rev-parse --short HEAD 2>/dev/null || echo 'unknown')"
	@echo "• Last Updated: $(shell git log -1 --format='%ad' --date=short 2>/dev/null || echo 'unknown')"

status: ## Show project status
	@echo "\n\033[1m$(PROJECT_NAME) Status\033[0m"
	@echo "=================="
	@echo "• Version: $(VERSION)"
	@echo "• Git Branch: $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'not a git repository')"
	@echo "• Uncommitted Changes: $(shell git status --porcelain 2>/dev/null | wc -l) files"
	@echo "• Last Commit: $(shell git log -1 --pretty=format:'%h - %s (%cr)' 2>/dev/null || echo 'no commits')"
	@echo "\n\033[1mProject Structure\033[0m"
	@echo "----------------"
	@if [ -d "$(COLLECTIONS_DIR)" ]; then \
		COLLECTIONS_COUNT=$$(find "$(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)" -maxdepth 1 -type d 2>/dev/null | wc -l); \
		echo "• Collections: $$(($$COLLECTIONS_COUNT-1)) in $(NAMESPACE) namespace"; \
	else \
		echo "\033[1;33m• Collections directory missing: $(COLLECTIONS_DIR)\033[0m"; \
	fi
	@echo "\nAvailable Collections:"
	@for collection in $(COLLECTIONS); do \
		echo "- $$collection"; \
	done

# ====================================================================
# Formatting
# ====================================================================
# Installation
# ====================================================================

# Installation alias for backward compatibility
install: inst-build ## Alias for inst-build

# ====================================================================
# Version Management and Publishing
# ====================================================================
# Note: Version management targets are in Makefile.targets
# ====================================================================
# Include additional targets from Makefile.targets
# ====================================================================
-include Makefile.targets
