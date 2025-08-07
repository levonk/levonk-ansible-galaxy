# ====================================================================
# Makefile for Managing Ansible Collections Namespaces
#
# This Makefile provides targets for managing and operating on collection
# namespaces within the project. It serves as an entry point for
# namespace-level operations and delegates to individual collection
# Makefiles when needed.
#
# See also: ../../Makefile (collections) for collection-level operations
# ====================================================================

# Include common variables and functions
-include ../../common.mk

# ====================================================================
# Configuration
# ====================================================================

# Default target namespace (can be overridden)
NAMESPACE ?= levonk

# Directories
ROOT_DIR ?= $(shell pwd)/../..
COLLECTIONS_DIR ?= $(ROOT_DIR)/ansible-galaxy/collections/ansible_collections
NAMESPACE_DIR ?= $(COLLECTIONS_DIR)/$(NAMESPACE)
DIST_DIR ?= $(ROOT_DIR)/dist/namespaces
BUILD_DIR ?= $(ROOT_DIR)/build/namespaces

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help list-namespaces list-collections build test lint format clean check-env check-tools version status

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mNamespace Management - Available Targets\033[0m"
	@echo "========================================"
	@echo "\n\033[1mNamespace Management\033[0m"
	@echo "------------------"
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | grep -v '## @' | sort
	@echo "\nRun 'make <target> NAMESPACE=<name>' to operate on a specific namespace\n"

# ====================================================================
# Namespace Operations
# ====================================================================

# Default target
all: help

# List available namespaces
list-namespaces: ## List all available namespaces
	@echo "\n${GREEN}Available Namespaces:${NC}"
	@echo "===================="
	@if [ -d "$(COLLECTIONS_DIR)" ]; then \
		ls -1 "$(COLLECTIONS_DIR)" 2>/dev/null || echo "${YELLOW}No namespaces found${NC}"; \
	else \
		echo "${YELLOW}No namespaces directory found at $(COLLECTIONS_DIR)${NC}"; \
	fi

# List collections in a namespace
list-collections: check-namespace ## List collections in the specified namespace
	@echo "\n${GREEN}Collections in ${NAMESPACE} namespace:${NC}"
	@echo "================================"
	@if [ -d "$(NAMESPACE_DIR)" ]; then \
		for col in $$(ls -1 "$(NAMESPACE_DIR)" 2>/dev/null); do \
			if [ -d "$(NAMESPACE_DIR)/$$col" ]; then \
				echo "- $$col"; \
			fi; \
		done || echo "${YELLOW}No collections found in $(NAMESPACE) namespace${NC}"; \
	else \
		echo "${YELLOW}Namespace '$(NAMESPACE)' not found in $(COLLECTIONS_DIR)${NC}"; \
	fi

# Build all collections in a namespace
build: check-namespace ## Build all collections in the specified namespace
	@echo "\n${GREEN}Building all collections in ${NAMESPACE} namespace...${NC}"
	@if [ -d "$(NAMESPACE_DIR)" ]; then \
		for col in $$(ls -1 "$(NAMESPACE_DIR)" 2>/dev/null); do \
			if [ -f "$(NAMESPACE_DIR)/$$col/Makefile" ]; then \
				echo "\n${GREEN}Building $$col...${NC}"; \
				$(MAKE) -C "$(NAMESPACE_DIR)/$$col" build || exit 1; \
			fi; \
		done; \
	else \
		echo "${YELLOW}Namespace '$(NAMESPACE)' not found in $(COLLECTIONS_DIR)${NC}"; \
	fi

# Test all collections in a namespace
test: check-namespace ## Test all collections in the specified namespace
	@echo "\n${GREEN}Testing all collections in ${NAMESPACE} namespace...${NC}"
	@if [ -d "$(NAMESPACE_DIR)" ]; then \
		for col in $$(ls -1 "$(NAMESPACE_DIR)" 2>/dev/null); do \
			if [ -f "$(NAMESPACE_DIR)/$$col/Makefile" ]; then \
				echo "\n${GREEN}Testing $$col...${NC}"; \
				$(MAKE) -C "$(NAMESPACE_DIR)/$$col" test || exit 1; \
			fi; \
		done; \
	else \
		echo "${YELLOW}Namespace '$(NAMESPACE)' not found in $(COLLECTIONS_DIR)${NC}"; \
	fi

# Lint all collections in a namespace
lint: check-namespace check-tools ## Lint all collections in the specified namespace
	@echo "\n${GREEN}Linting all collections in ${NAMESPACE} namespace...${NC}"
	@if [ -d "$(NAMESPACE_DIR)" ]; then \
		for col in $$(ls -1 "$(NAMESPACE_DIR)" 2>/dev/null); do \
			if [ -f "$(NAMESPACE_DIR)/$$col/Makefile" ]; then \
				echo "\n${GREEN}Linting $$col...${NC}"; \
				$(MAKE) -C "$(NAMESPACE_DIR)/$$col" lint || exit 1; \
			fi; \
		done; \
	else \
		echo "${YELLOW}Namespace '$(NAMESPACE)' not found in $(COLLECTIONS_DIR)${NC}"; \
	fi

# Format all collections in a namespace
format: check-namespace check-tools ## Format code in all collections in the specified namespace
	@echo "\n${GREEN}Formatting all collections in ${NAMESPACE} namespace...${NC}"
	@if [ -d "$(NAMESPACE_DIR)" ]; then \
		for col in $$(ls -1 "$(NAMESPACE_DIR)" 2>/dev/null); do \
			if [ -f "$(NAMESPACE_DIR)/$$col/Makefile" ]; then \
				echo "\n${GREEN}Formatting $$col...${NC}"; \
				$(MAKE) -C "$(NAMESPACE_DIR)/$$col" format || exit 1; \
			fi; \
		done; \
	else \
		echo "${YELLOW}Namespace '$(NAMESPACE)' not found in $(COLLECTIONS_DIR)${NC}"; \
	fi

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "\n${YELLOW}Cleaning build artifacts...${NC}"
	@rm -rf "$(DIST_DIR)/$(NAMESPACE)" "$(BUILD_DIR)/$(NAMESPACE)"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# ====================================================================
# Helper Targets
# ====================================================================

# Check if required tools are installed
check-tools:
	@echo "\n${GREEN}Checking for required tools...${NC}"
	@command -v ansible >/dev/null 2>&1 || { echo >&2 "${RED}Error: ansible is required but not installed.${NC}"; exit 1; }
	@command -v ansible-galaxy >/dev/null 2>&1 || { echo >&2 "${RED}Error: ansible-galaxy is required but not installed.${NC}"; exit 1; }
	@command -v yamllint >/dev/null 2>&1 || { echo >&2 "${YELLOW}Warning: yamllint is not installed. Linting will be limited.${NC}"; }
	@command -v ansible-lint >/dev/null 2>&1 || { echo >&2 "${YELLOW}Warning: ansible-lint is not installed. Linting will be limited.${NC}"; }

# Check if namespace is specified and exists
check-namespace:
	@if [ -z "$(NAMESPACE)" ]; then \
		echo "${RED}Error: NAMESPACE variable is not set. Please specify a namespace.${NC}"; \
		echo "Available namespaces:"; \
		$(MAKE) list-namespaces; \
		exit 1; \
	elif [ ! -d "$(NAMESPACE_DIR)" ]; then \
		echo "${RED}Error: Namespace '$(NAMESPACE)' not found in $(COLLECTIONS_DIR)${NC}"; \
		echo "Available namespaces:"; \
		$(MAKE) list-namespaces; \
		exit 1; \
	fi

# Show version information
version: ## Show version information
	@echo "\n${GREEN}Namespace Version Information${NC}"
	@echo "=========================="
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Current Namespace: $(NAMESPACE)"
	@echo "Collections Directory: $(COLLECTIONS_DIR)"

# Show status of namespaces and collections
status: ## Show status of namespaces and collections
	@echo "\n${GREEN}Namespace and Collections Status${NC}"
	@echo "=============================="
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Collections Directory: $(COLLECTIONS_DIR)"
	@echo "\n${GREEN}Available Namespaces:${NC}"
	@$(MAKE) -s list-namespaces
	@echo "\n${GREEN}Collections in ${NAMESPACE} namespace:${NC}"
	@$(MAKE) -s list-collections

# ====================================================================
# End of Makefile
# ====================================================================
