# ====================================================================
# Makefile for tests in {{ namespace_name }}.{{ collection_name }}
#
# This Makefile provides targets for running and managing tests within the
# collection, including unit tests, integration tests, and test environment
# management.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Test directories
TEST_TYPES := $(notdir $(wildcard *))

# Phony targets
.PHONY: all test unit integration lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run all tests
test: unit integration ## Run all tests (unit and integration)

# Run unit tests
unit: ## Run unit tests
	@echo "${GREEN}Running unit tests...${NC}"
	@if [ -d "unit" ]; then \
		cd unit && $(MAKE) test; \
	else \
		echo "${YELLOW}No unit tests directory found.${NC}"; \
	fi

# Run integration tests
integration: ## Run integration tests
	@echo "${GREEN}Running integration tests...${NC}"
	@if [ -d "integration" ]; then \
		cd integration && $(MAKE) test; \
	else \
		echo "${YELLOW}No integration tests directory found.${NC}"; \
	fi

# Lint test files
lint: ## Lint test files
	@echo "${GREEN}Running linters on test files...${NC}"
	@if command -v yamllint >/dev/null; then \
		echo "${YELLOW}Running yamllint...${NC}"; \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping YAML linting${NC}"; \
	fi
	@if command -v ansible-lint >/dev/null; then \
		echo "${YELLOW}Running ansible-lint...${NC}"; \
		ansible-lint -v; \
	else \
		echo "${YELLOW}ansible-lint not found, skipping Ansible linting${NC}"; \
	fi

# Format test files
format: ## Format test files
	@echo "${GREEN}Formatting test files...${NC}"
	@if command -v yamllint >/dev/null; then \
		echo "${YELLOW}Formatting YAML files...${NC}"; \
		find . -name '*.yml' -o -name '*.yaml' | xargs yamllint --format=auto --fix || true; \
	fi
	@echo "${GREEN}Formatting complete.${NC}"

# Clean test artifacts
clean: ## Clean test artifacts
	@echo "${YELLOW}Cleaning test artifacts...${NC}"
	@for test_type in $(TEST_TYPES); do \
		if [ -d "$$test_type" ] && [ -f "$$test_type/Makefile" ]; then \
			$(MAKE) -C "$$test_type" clean || true; \
		fi; \
	done
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# List available test types
list: ## List all available test types
	@echo "${GREEN}Available test types in {{ namespace_name }}.{{ collection_name }}:${NC}"
	@echo "======================================"
	@for test_type in $(TEST_TYPES); do \
		if [ -d "$$test_type" ]; then \
			echo "- $$test_type"; \
		fi; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ namespace_name }}.{{ collection_name }} - Tests Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
