# ====================================================================
# Makefile for Managing Ansible Collections
#
# This Makefile provides targets for managing and operating on collections
# within the project. It serves as the entry point for collection-level
# operations and delegates to individual collection Makefiles when needed.
#
# See also: ../Makefile (root) for project-wide operations
# ====================================================================

# Include common variables and functions
-include ../common.mk

# ====================================================================
# Configuration
# ====================================================================

# Default target collection (can be overridden)
COLLECTION ?= all

# Build configuration
BUILD_DIR ?= $(ROOT_DIR)/build/collections
DIST_DIR ?= $(ROOT_DIR)/dist/collections
COLLECTIONS_DIR ?= $(ROOT_DIR)/ansible-galaxy/collections/ansible_collections/$(NAMESPACE)

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help list-collections list-namespaces clean build test lint format check-env check-tools version status

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mCollections Management - Available Targets\033[0m"
	@echo "=================================================="
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# ====================================================================
# Collection Operations
# ====================================================================

# Default target
all: help

# List available collections
list-collections: ## List all available collections
	@echo "\n${GREEN}Available Collections in ${NAMESPACE} namespace:${NC}"
	@echo "=========================================="
	@if [ -d "$(COLLECTIONS_DIR)" ]; then \
		for col in $(COLLECTIONS); do \
			if [ -d "$(COLLECTIONS_DIR)/$$col" ]; then \
				echo "- $$col"; \
			fi; \
		done; \
	else \
		echo "${YELLOW}No collections found in $(COLLECTIONS_DIR)${NC}"; \
	fi

# List available namespaces
list-namespaces: ## List all available namespaces
	@echo "\n${GREEN}Available Namespaces:${NC}"
	@echo "===================="
	@if [ -d "$(COLLECTIONS_DIR)/.." ]; then \
		ls -1 "$(COLLECTIONS_DIR)/.." 2>/dev/null || echo "${YELLOW}No namespaces found${NC}"; \
	else \
		echo "${YELLOW}No namespaces found in $(COLLECTIONS_DIR)/..${NC}"; \
	fi

# Build all or specified collection
build: check-env ## Build collection(s)
	@echo "\n${GREEN}Building collection(s)...${NC}"
	@if [ "$(COLLECTION)" = "all" ]; then \
		for col in $(COLLECTIONS); do \
			if [ -d "$(COLLECTIONS_DIR)/$$col" ]; then \
				$(MAKE) -C "$(COLLECTIONS_DIR)/$$col" build || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTIONS_DIR)/$(COLLECTION)" ]; then \
			$(MAKE) -C "$(COLLECTIONS_DIR)/$(COLLECTION)" build; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found in $(NAMESPACE) namespace${NC}"; \
			exit 1; \
		fi; \
	fi

# Test all or specified collection
test: check-env ## Run tests for collection(s)
	@if [ "$(COLLECTION)" = "all" ]; then \
		for col in $(COLLECTIONS); do \
			if [ -d "$(COLLECTIONS_DIR)/$$col" ]; then \
				$(MAKE) -C "$(COLLECTIONS_DIR)/$$col" test || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTIONS_DIR)/$(COLLECTION)" ]; then \
			$(MAKE) -C "$(COLLECTIONS_DIR)/$(COLLECTION)" test; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found in $(NAMESPACE) namespace${NC}"; \
			exit 1; \
		fi; \
	fi

# Lint all or specified collection
lint: check-tools ## Run linters on collection(s)
	@if [ "$(COLLECTION)" = "all" ]; then \
		for col in $(COLLECTIONS); do \
			if [ -d "$(COLLECTIONS_DIR)/$$col" ]; then \
				$(MAKE) -C "$(COLLECTIONS_DIR)/$$col" lint || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTIONS_DIR)/$(COLLECTION)" ]; then \
			$(MAKE) -C "$(COLLECTIONS_DIR)/$(COLLECTION)" lint; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found in $(NAMESPACE) namespace${NC}"; \
			exit 1; \
		fi; \
	fi

# Format code in all or specified collection
format: check-tools ## Format code in collection(s)
	@if [ "$(COLLECTION)" = "all" ]; then \
		for col in $(COLLECTIONS); do \
			if [ -d "$(COLLECTIONS_DIR)/$$col" ]; then \
				$(MAKE) -C "$(COLLECTIONS_DIR)/$$col" format || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTIONS_DIR)/$(COLLECTION)" ]; then \
			$(MAKE) -C "$(COLLECTIONS_DIR)/$(COLLECTION)" format; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found in $(NAMESPACE) namespace${NC}"; \
			exit 1; \
		fi; \
	fi

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "\n${YELLOW}Cleaning build artifacts...${NC}"
	@rm -rf "$(DIST_DIR)" "$(BUILD_DIR)"
	@find . -name '*.retry' -delete -o -name '*.pyc' -delete
	@find . -name '__pycache__' -type d -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# ====================================================================
# Environment and Tooling
# ====================================================================

# Check if required environment is set up
check-env:
	@if [ -z "$(NAMESPACE)" ]; then \
		echo "${RED}Error: NAMESPACE variable is not set. Please include common.mk${NC}"; \
		exit 1; \
	fi

# Check if required tools are installed
check-tools: check-env
	@echo "\n${GREEN}Checking for required tools...${NC}"
	@command -v ansible >/dev/null 2>&1 || { echo >&2 "${RED}Error: ansible is required but not installed.${NC}"; exit 1; }
	@command -v ansible-galaxy >/dev/null 2>&1 || { echo >&2 "${RED}Error: ansible-galaxy is required but not installed.${NC}"; exit 1; }
	@command -v yamllint >/dev/null 2>&1 || { echo >&2 "${YELLOW}Warning: yamllint is not installed. Linting will be limited.${NC}"; }
	@command -v ansible-lint >/dev/null 2>&1 || { echo >&2 "${YELLOW}Warning: ansible-lint is not installed. Linting will be limited.${NC}"; }

# Show version information
version: ## Show version information
	@echo "\n${GREEN}Collections Version Information${NC}"
	@echo "=============================="
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Namespace: $(NAMESPACE)"
	@echo "Collections: $(COLLECTIONS)"

# Show status of collections
status: ## Show status of collections
	@echo "\n${GREEN}Collections Status${NC}"
	@echo "=================="
	@for col in $(COLLECTIONS); do \
		if [ -d "$(COLLECTIONS_DIR)/$$col" ]; then \
			printf "${GREEN}✓${NC} %-20s" "$$col"; \
			if [ -f "$(COLLECTIONS_DIR)/$$col/galaxy.yml" ]; then \
				version=$$(grep '^version:' "$(COLLECTIONS_DIR)/$$col/galaxy.yml" | awk '{print $$2}'); \
				echo "  version: $${version:-unknown}"; \
			else \
				echo "  ${YELLOW}(no galaxy.yml found)${NC}"; \
			fi; \
		else \
			echo "${RED}✗ $${col} (missing)${NC}"; \
		fi; \
	done

# ====================================================================
# End of Makefile
# ====================================================================