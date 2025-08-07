# ====================================================================
# Root Makefile for levonk-ansible-galaxy
# This file provides top-level targets and forwards commands to subdirectories
# ====================================================================

# Include common variables
-include ansible-galaxy/common.mk

# ====================================================================
# Project Configuration
# ====================================================================
PROJECT_NAME ?= levonk-ansible-galaxy
BIN_DIR ?= $(shell pwd)/bin
VERSION ?= $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")
DIST_DIR ?= $(shell pwd)/dist
ANSIBLE_GALAXY_DIR ?= ansible-galaxy

# Standard directories
DOCS_DIR ?= docs
TESTS_DIR ?= tests
BUILD_DIR ?= build

# Tool commands
PYTHON ?= python3
PIP ?= pip3

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help list list-collections dev-beta debug-beta FORCE \
        clean format lint test build install uninstall \
        publish-beta publish-prod install-beta install-prod install-src \
        check-env check-tools docs version status \
        check check-ansible check-yaml check-markdown \
        setup setup-dev setup-test setup-docs \
        pre-commit pre-commit-install pre-commit-run pre-commit-clean

# ====================================================================
# Default Target
# ====================================================================
.DEFAULT_GOAL := help

# Alias for default target
all: help

# ====================================================================
# Help and Documentation
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m$(PROJECT_NAME) - Available Targets\033[0m"
	@echo "=================================================="
	@echo "\n\033[1mProject Information:\033[0m"
	@echo "  Version: $(VERSION)"
	@echo "  Path: $(shell pwd)"

	@echo "\n\033[1mCore Targets:\033[0m"
	@echo "  make all              Build and test everything (default)"
	@echo "  make build            Build all components"
	@echo "  make test             Run all tests"
	@echo "  make lint             Run all linters"
	@echo "  make format           Format all source files"
	@echo "  make clean            Remove build artifacts"

	@echo "\n\033[1mDevelopment:\033[0m"
	@echo "  make check-env        Check development environment"
	@echo "  make check-tools      Verify required tools are installed"
	@echo "  make setup            Setup development environment"
	@echo "  make docs             Generate documentation"
	@echo "  make version          Show version information"
	@echo "  make status           Show project status"

	@echo "\n\033[1mPublishing:\033[0m"
	@echo "  make publish-beta     Publish to beta channel"
	@echo "  make publish-prod     Publish to production"

	@echo "\n\033[1mAnsible Galaxy Targets (in $(ANSIBLE_GALAXY_DIR)):\033[0m"
	@cd $(ANSIBLE_GALAXY_DIR) && \
	$(MAKE) --no-print-directory help-targets 2>/dev/null || \
	echo "  (Run 'make' in the ansible-galaxy directory to see all targets)"

	@echo "\n\033[1mFor more information:\033[0m"
	@echo "  • Run 'make <target> --help' for target-specific help"
	@echo "  • Check the README.md for detailed documentation"
	@echo "  • Review the Makefile for additional targets"

# ====================================================================
# Collection Management
# ====================================================================

list list-collections: ## List available collections in the levonk namespace
	@echo "\n\033[1mAvailable Collections\033[0m"
	@echo "==================="
	@if [ ! -d "$(ANSIBLE_GALAXY_DIR)" ]; then \
		echo "\033[1;31mError: Ansible Galaxy directory not found at $(ANSIBLE_GALAXY_DIR)\033[0m"; \
		exit 1; \
	fi
	@if [ -d "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk" ]; then \
		COUNT=$$(find "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk" -maxdepth 1 -type d | wc -l); \
		if [ "$$COUNT" -le 1 ]; then \
			echo "\033[1;33mNo collections found in levonk namespace\033[0m"; \
		else \
			echo "\033[1;32mCollections in levonk namespace ($$(($$COUNT-1)) found):\033[0m"; \
			ls -1 "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk" | grep -v '^\..*' | sort | awk '{print "  • " $$0}'; \
		fi \
	else \
		echo "\033[1;33mNo collections found in levonk namespace (directory does not exist)\033[0m"; \
		echo "  Expected path: $(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk"; \
		echo "  Run 'make setup' to initialize the project structure if needed"; \
	fi

# ====================================================================
# Development Targets
# ====================================================================

clean: ## Remove build artifacts and temporary files
	@echo "\n\033[1mCleaning Project\033[0m"
	@echo "==============="
	@if [ -d "$(DIST_DIR)" ]; then \
		echo "• Removing distribution directory: $(DIST_DIR)"; \
		rm -rf "$(DIST_DIR)"; \
	fi
	@if [ -d "$(BUILD_DIR)" ]; then \
		echo "• Removing build directory: $(BUILD_DIR)"; \
		rm -rf "$(BUILD_DIR)"; \
	fi
	@if [ -d "$(ANSIBLE_GALAXY_DIR)/.markers" ]; then \
		echo "• Cleaning marker files"; \
		rm -f "$(ANSIBLE_GALAXY_DIR)/.markers/*.marker"; \
	fi
	@echo "\n\033[1;32m✓ Clean complete\033[0m"

format: ## Format all source code
	@echo "\n\033[1mFormatting Code\033[0m"
	@echo "=============="
	@if command -v yamlfmt >/dev/null 2>&1; then \
		echo "• Formatting YAML files"; \
		find . -name "*.yml" -o -name "*.yaml" | xargs -r yamlfmt -w; \
	else \
		echo "\033[1;33m• yamlfmt not found, skipping YAML formatting\033[0m"; \
	fi

lint: ## Run all linters
	@echo "\n\033[1mRunning Linters\033[0m"
	@echo "=============="
	@if command -v yamllint >/dev/null 2>&1; then \
		echo "• Linting YAML files"; \
		yamllint .; \
	else \
		echo "\033[1;33m• yamllint not found, skipping YAML linting\033[0m"; \
	fi

test: ## Run all tests
	@echo "\n\033[1mRunning Tests\033[0m"
	@echo "============"
	@if [ -d "$(TESTS_DIR)" ]; then \
		echo "• Running tests from $(TESTS_DIR) directory"; \
		$(MAKE) -C "$(TESTS_DIR)"; \
	else \
		echo "\033[1;33m• No tests directory found at $(TESTS_DIR)\033[0m"; \
	fi

dev-beta: ## Development version of beta that skips token check
	@echo "\n\033[1mDevelopment Beta Mode\033[0m"
	@echo "=================="
	@mkdir -p "$(ANSIBLE_GALAXY_DIR)/.markers"
	@touch "$(ANSIBLE_GALAXY_DIR)/.markers/beta.marker"
	@echo "✓ Created beta marker file for development"
	@echo "  (Skipping actual publishing)"

debug-beta: ## Debug Galaxy authentication issues
	@echo "\n\033[1mDebugging Galaxy Authentication\033[0m"
	@echo "=============================="
	@if [ -z "$${ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "\033[1;33mWARNING: ANSIBLE_GALAXY_TOKEN is not set\033[0m"; \
	else \
		echo "• Token length: $${#ANSIBLE_GALAXY_TOKEN} characters"; \
		echo "• Token prefix: $${ANSIBLE_GALAXY_TOKEN:0:3}..."; \
	fi
	@echo "\n\033[1mChecking server connectivity...\033[0m"
	@cd $(ANSIBLE_GALAXY_DIR) && \
	GALAXY_SERVER="https://galaxy-dev.ansible.com" \
	ANSIBLE_VERBOSITY=3 \
	ansible-galaxy collection list --server="https://galaxy-dev.ansible.com"
	@echo "\n\033[1mTesting API v3 endpoint...\033[0m"
	@curl -s -I -H "Authorization: Token $${ANSIBLE_GALAXY_TOKEN:-none}" \
		"https://galaxy-dev.ansible.com/api/v3/" | \
		head -n 1 | \
		awk '{if ($$2 == "200") print "\033[1;32m• API v3 endpoint is accessible\033[0m"; else print "\033[1;31m• API v3 endpoint returned: " $$0 "\033[0m"}'

# ====================================================================
# Environment and Tools
# ====================================================================

check-env: ## Check development environment setup
	@echo "\n\033[1mChecking Development Environment\033[0m"
	@echo "================================"
	@echo "• Project: $(PROJECT_NAME)"
	@echo "• Version: $(VERSION)"
	@echo "• Path: $(shell pwd)"
	@echo "• Python: $(shell $(PYTHON) --version 2>/dev/null || echo 'Not found')"
	@echo "• Pip: $(shell $(PIP) --version 2>/dev/null || echo 'Not found')"
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
			VERSION=$$($$tool --version 2>&1 | head -n 1 | cut -d' ' -f2-); \
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
# Documentation
# ====================================================================

docs: ## Generate project documentation
	@echo "\n\033[1mGenerating Documentation\033[0m"
	@echo "======================"
	@if [ -f "$(BIN_DIR)/generate-docs" ]; then \
		"$(BIN_DIR)/generate-docs"; \
	elif [ -f "$(DOCS_DIR)/Makefile" ]; then \
		$(MAKE) -C "$(DOCS_DIR)"; \
	else \
		echo "\033[1;33mNo documentation generator found\033[0m"; \
		echo "• Looked in: $(BIN_DIR)/generate-docs"; \
		echo "• Looked in: $(DOCS_DIR)/Makefile"; \
	fi

# ====================================================================
# Version and Status
# ====================================================================

version: ## Display project version information
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
	@if [ -d "$(ANSIBLE_GALAXY_DIR)" ]; then \
		COLLECTIONS_COUNT=$$(find "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections" -maxdepth 1 -type d 2>/dev/null | wc -l); \
		echo "• Ansible Galaxy: $$(($$COLLECTIONS_COUNT-1)) collections"; \
	else \
		echo "\033[1;33m• Ansible Galaxy directory missing\033[0m"; \
	fi

# ====================================================================
# Target Forwarding
# ====================================================================

# Forward all other targets to the ansible-galaxy directory
%: FORCE
	@if [ -f "$(ANSIBLE_GALAXY_DIR)/Makefile" ]; then \
		cd $(ANSIBLE_GALAXY_DIR) && $(MAKE) $@; \
	else \
		echo "Error: $(ANSIBLE_GALAXY_DIR)/Makefile not found"; \
		exit 1; \
	fi

# ====================================================================
# Utility Targets
# ====================================================================

# Force target to always run commands
FORCE:

# ====================================================================
# Include common targets from subdirectories
# ====================================================================

# Include common makefile if it exists
-include common.mk
