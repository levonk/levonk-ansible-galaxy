# ====================================================================
# Makefile for plugins in {{ namespace_name }}.{{ collection_name }}
#
# This Makefile provides targets for managing all plugins within the
# collection, including testing, validation, and documentation.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Plugin types
PLUGIN_TYPES := $(notdir $(wildcard *))

# Phony targets
.PHONY: all test lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Test plugins
test: ## Test all plugins
	@echo "${GREEN}Running tests for plugins...${NC}"
	@if [ -d "tests" ]; then \
		ansible-test sanity --docker default; \
	else \
		echo "${YELLOW}No tests directory found.${NC}"; \
	fi

# Lint plugins
lint: ## Lint all plugins
	@echo "${GREEN}Running linters on plugins...${NC}"
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

# Format code
format: ## Format plugin code
	@echo "${GREEN}Formatting plugin code...${NC}"
	@if command -v yamllint >/dev/null; then \
		echo "${YELLOW}Formatting YAML files...${NC}"; \
		find . -name '*.yml' -o -name '*.yaml' | xargs yamllint --format=auto --fix || true; \
	fi
	@echo "${GREEN}Formatting complete.${NC}"

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${NC}"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# List available plugins
list: ## List all available plugins
	@echo "${GREEN}Available plugins in {{ namespace_name }}.{{ collection_name }}:${NC}"
	@echo "======================================"
	@for type in $(PLUGIN_TYPES); do \
		if [ -d "$$type" ]; then \
			echo "\n${YELLOW}$$type:${NC}"; \
			find "$$type" -type f | sort | sed 's/^/  /'; \
		fi; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ namespace_name }}.{{ collection_name }} - Plugins Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
