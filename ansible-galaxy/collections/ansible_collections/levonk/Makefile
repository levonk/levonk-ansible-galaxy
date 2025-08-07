# ====================================================================
# Makefile for levonk Namespace
#
# This Makefile provides targets for managing and operating on collections
# within the levonk namespace. It serves as an entry point for namespace-level
# operations and delegates to individual collection Makefiles when needed.
# ====================================================================

# Include common variables and functions
-include ../../../common.mk

# ====================================================================
# Configuration
# ====================================================================

# Default target collection (can be overridden)
COLLECTION ?= all

# Collections in this namespace (exclude special directories)
COLLECTIONS ?= $(filter-out __pycache__ .pytest_cache,$(wildcard *))

# Directories
ROOT_DIR ?= $(shell pwd)/../../..
DIST_DIR ?= $(ROOT_DIR)/dist/levonk
BUILD_DIR ?= $(ROOT_DIR)/build/levonk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help list-collections test lint build format clean check-env check-tools version status

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mlevonk Namespace - Available Targets\033[0m"
	@echo "========================================"
	@echo "\n\033[1mCollection Management\033[0m"
	@echo "-------------------"
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_-]+:.*## / {if ($$1 !~ /-/) printf "  \\033[36m%-20s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mIndividual Collection Operations\033[0m"
	@echo "--------------------------------"
	@echo "  make <collection>-test     Run tests for a specific collection"
	@echo "  make <collection>-lint     Run linters for a specific collection"
	@echo "  make <collection>-build    Build a specific collection"
	@echo "  make <collection>-format   Format code in a specific collection"
	@echo "  make <collection>-clean    Clean a specific collection"
	@echo "\nRun 'make <target> COLLECTION=<name>' to operate on a specific collection"
	@echo "Example: make test COLLECTION=common"

# ====================================================================
# Collection Operations
# ====================================================================

# Default target
all: help

# List available collections
list-collections: ## List all available collections in this namespace
	@echo "\n${GREEN}Available Collections in levonk namespace:${NC}"
	@echo "===================================="
	@for col in $(COLLECTIONS); do \
		if [ -d "$$col" ]; then \
			echo "- $$col"; \
		fi; \
	done

# Build all or specified collection
build: check-env ## Build collection(s)
	@if [ "$(COLLECTION)" = "all" ]; then \
		echo "\n${GREEN}Building all collections...${NC}"; \
		for col in $(COLLECTIONS); do \
			if [ -d "$$col" ] && [ -f "$$col/Makefile" ]; then \
				echo "\n${GREEN}Building $$col...${NC}"; \
				$(MAKE) -C "$$col" build || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTION)" ] && [ -f "$(COLLECTION)/Makefile" ]; then \
			echo "\n${GREEN}Building $(COLLECTION)...${NC}"; \
			$(MAKE) -C "$(COLLECTION)" build; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found or has no Makefile${NC}"; \
			echo "Available collections:"; \
			$(MAKE) -s list-collections; \
			exit 1; \
		fi; \
	fi

# Test all or specified collection
test: check-env ## Run tests for collection(s)
	@if [ "$(COLLECTION)" = "all" ]; then \
		echo "\n${GREEN}Testing all collections...${NC}"; \
		for col in $(COLLECTIONS); do \
			if [ -d "$$col" ] && [ -f "$$col/Makefile" ]; then \
				echo "\n${GREEN}Testing $$col...${NC}"; \
				$(MAKE) -C "$$col" test || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTION)" ] && [ -f "$(COLLECTION)/Makefile" ]; then \
			echo "\n${GREEN}Testing $(COLLECTION)...${NC}"; \
			$(MAKE) -C "$(COLLECTION)" test; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found or has no Makefile${NC}"; \
			echo "Available collections:"; \
			$(MAKE) -s list-collections; \
			exit 1; \
		fi; \
	fi

# Lint all or specified collection
lint: check-tools ## Run linters on collection(s)
	@if [ "$(COLLECTION)" = "all" ]; then \
		echo "\n${GREEN}Linting all collections...${NC}"; \
		for col in $(COLLECTIONS); do \
			if [ -d "$$col" ] && [ -f "$$col/Makefile" ]; then \
				echo "\n${GREEN}Linting $$col...${NC}"; \
				$(MAKE) -C "$$col" lint || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTION)" ] && [ -f "$(COLLECTION)/Makefile" ]; then \
			echo "\n${GREEN}Linting $(COLLECTION)...${NC}"; \
			$(MAKE) -C "$(COLLECTION)" lint; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found or has no Makefile${NC}"; \
			echo "Available collections:"; \
			$(MAKE) -s list-collections; \
			exit 1; \
		fi; \
	fi

# Format code in all or specified collection
format: check-tools ## Format code in collection(s)
	@if [ "$(COLLECTION)" = "all" ]; then \
		echo "\n${GREEN}Formatting all collections...${NC}"; \
		for col in $(COLLECTIONS); do \
			if [ -d "$$col" ] && [ -f "$$col/Makefile" ]; then \
				echo "\n${GREEN}Formatting $$col...${NC}"; \
				$(MAKE) -C "$$col" format || exit 1; \
			fi; \
		done; \
	else \
		if [ -d "$(COLLECTION)" ] && [ -f "$(COLLECTION)/Makefile" ]; then \
			echo "\n${GREEN}Formatting $(COLLECTION)...${NC}"; \
			$(MAKE) -C "$(COLLECTION)" format; \n		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found or has no Makefile${NC}"; \
			echo "Available collections:"; \
			$(MAKE) -s list-collections; \
			exit 1; \
		fi; \
	fi

# Clean build artifacts
clean: ## Clean build artifacts
	@if [ "$(COLLECTION)" = "all" ]; then \
		echo "\n${YELLOW}Cleaning all collections...${NC}"; \
		for col in $(COLLECTIONS); do \
			if [ -d "$$col" ] && [ -f "$$col/Makefile" ]; then \
				echo "\n${YELLOW}Cleaning $$col...${NC}"; \
				$(MAKE) -C "$$col" clean || true; \
			fi; \
		done; \
		echo "\n${GREEN}Clean complete.${NC}"; \
	else \
		if [ -d "$(COLLECTION)" ] && [ -f "$(COLLECTION)/Makefile" ]; then \
			echo "\n${YELLOW}Cleaning $(COLLECTION)...${NC}"; \
			$(MAKE) -C "$(COLLECTION)" clean; \
		else \
			echo "${RED}Error: Collection '$(COLLECTION)' not found or has no Makefile${NC}"; \
			echo "Available collections:"; \
			$(MAKE) -s list-collections; \
			exit 1; \
		fi; \
	fi
	@rm -rf "$(DIST_DIR)" "$(BUILD_DIR)"

# ====================================================================
# Individual Collection Operations (Pattern Rules)
# ====================================================================

# These pattern rules allow operations on individual collections using the syntax:
#   make <collection>-<target>
# Example: make common-test

%-test: ## Run tests for a specific collection (make <collection>-test)
	@if [ -d "$*" ] && [ -f "$*/Makefile" ]; then \
		echo "\n${GREEN}Testing $*...${NC}"; \
		$(MAKE) -C "$*" test; \
	else \
		echo "${RED}Error: Collection '$*' not found or has no Makefile${NC}"; \
		echo "Available collections:"; \
		$(MAKE) -s list-collections; \
		exit 1; \
	fi

%-lint: ## Run linters for a specific collection (make <collection>-lint)
	@if [ -d "$*" ] && [ -f "$*/Makefile" ]; then \
		echo "\n${GREEN}Linting $*...${NC}"; \
		$(MAKE) -C "$*" lint; \
	else \
		echo "${RED}Error: Collection '$*' not found or has no Makefile${NC}"; \
		echo "Available collections:"; \
		$(MAKE) -s list-collections; \
		exit 1; \
	fi

%-build: ## Build a specific collection (make <collection>-build)
	@if [ -d "$*" ] && [ -f "$*/Makefile" ]; then \
		echo "\n${GREEN}Building $*...${NC}"; \
		$(MAKE) -C "$*" build; \
	else \
		echo "${RED}Error: Collection '$*' not found or has no Makefile${NC}"; \
		echo "Available collections:"; \
		$(MAKE) -s list-collections; \
		exit 1; \
	fi

%-format: ## Format code in a specific collection (make <collection>-format)
	@if [ -d "$*" ] && [ -f "$*/Makefile" ]; then \
		echo "\n${GREEN}Formatting $*...${NC}"; \
		$(MAKE) -C "$*" format; \
	else \
		echo "${RED}Error: Collection '$*' not found or has no Makefile${NC}"; \
		echo "Available collections:"; \
		$(MAKE) -s list-collections; \
		exit 1; \
	fi

%-clean: ## Clean a specific collection (make <collection>-clean)
	@if [ -d "$*" ] && [ -f "$*/Makefile" ]; then \
		echo "\n${YELLOW}Cleaning $*...${NC}"; \
		$(MAKE) -C "$*" clean; \
	else \
		echo "${RED}Error: Collection '$*' not found or has no Makefile${NC}"; \
		echo "Available collections:"; \
		$(MAKE) -s list-collections; \
		exit 1; \
	fi

# ====================================================================
# Utility Functions
# ====================================================================

check-env: ## Check if required environment variables are set
	@if [ -z "$(ANSIBLE_GALAXY_TOKEN)" ]; then \
		echo "${RED}Error: ANSIBLE_GALAXY_TOKEN is not set${NC}"; \
		exit 1; \
	fi

check-tools: ## Check if required tools are installed
	@command -v ansible >/dev/null 2>&1 || { echo "${RED}Error: ansible is not installed${NC}" >&2; exit 1; }
	@command -v ansible-galaxy >/dev/null 2>&1 || { echo "${RED}Error: ansible-galaxy is not installed${NC}" >&2; exit 1; }
	@command -v yamllint >/dev/null 2>&1 || { echo "${YELLOW}Warning: yamllint is not installed, some checks may fail${NC}" >&2; }

version: ## Show version information
	@echo "\n${GREEN}levonk Namespace Version Information${NC}"
	@echo "=================================="
	@echo "Namespace: levonk"
	@echo "Number of collections: $(words $(COLLECTIONS))"
	@echo "Collections: $(COLLECTIONS)"

status: ## Show status of all collections
	@echo "\n${GREEN}levonk Namespace Status${NC}"
	@echo "======================="
	@for col in $(COLLECTIONS); do \
		if [ -d "$$col" ] && [ -f "$$col/Makefile" ]; then \
			echo -n "- ${GREEN}$$col${NC}: "; \
			if $(MAKE) -s -C "$$col" version >/dev/null 2>&1; then \
				echo "OK"; \
			else \
				echo "${YELLOW}WARNING: No version information available${NC}"; \
			fi; \
		fi; \
	done

# ====================================================================
# End of Makefile
# ====================================================================
