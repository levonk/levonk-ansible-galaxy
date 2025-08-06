# ====================================================================
# Makefile for modules in {{ namespace_name }}.{{ collection_name }}
#
# This Makefile provides targets for managing custom modules within the
# collection, including testing, validation, and documentation.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Module files
MODULES := $(wildcard *.py)
MODULE_NAMES = $(basename $(MODULES))

# Phony targets
.PHONY: all test lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Test modules
test: ## Test all modules
	@echo "${GREEN}Testing modules...${NC}"
	@for module in $(MODULES); do \
		echo "${YELLOW}Testing $${module}...${NC}"; \
		python -m ansible.modules.$${module} test || exit 1; \
	done

# Lint modules
lint: ## Lint all modules
	@echo "${GREEN}Running linters on modules...${NC}"
	@if command -v pylint >/dev/null; then \
		echo "${YELLOW}Running pylint...${NC}"; \
		pylint --disable=C0114,C0115,C0116 $(MODULES); \
	else \
		echo "${YELLOW}pylint not found, skipping Python linting${NC}"; \
	fi
	@if command -v ansible-lint >/dev/null; then \
		echo "${YELLOW}Running ansible-lint...${NC}"; \
		ansible-lint -v; \
	else \
		echo "${YELLOW}ansible-lint not found, skipping Ansible linting${NC}"; \
	fi

# Format code
format: ## Format module code
	@echo "${GREEN}Formatting module code...${NC}"
	@if command -v black >/dev/null; then \
		echo "${YELLOW}Formatting with black...${NC}"; \
		black $(MODULES); \
	else \
		echo "${YELLOW}black not found, skipping code formatting${NC}"; \
	fi
	@if command -v isort >/dev/null; then \
		echo "${YELLOW}Sorting imports with isort...${NC}"; \
		isort $(MODULES); \
	else \
		echo "${YELLOW}isort not found, skipping import sorting${NC}"; \
	fi

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${NC}"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# List available modules
list: ## List all available modules
	@echo "${GREEN}Available modules in {{ namespace_name }}.{{ collection_name }}:${NC}"
	@echo "======================================"
	@for module in $(MODULES); do \
		echo "- $$module"; \
	done

# Individual module targets
$(MODULE_NAMES): %: %.py
	@echo "${GREEN}Testing module: $<${NC}"
	python -m ansible.modules.$< test

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ namespace_name }}.{{ collection_name }} - Modules Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mAvailable Modules\033[0m"
	@echo "----------------"
	@for module in $(MODULE_NAMES); do \
		echo "  make $${module}"; \
	done

# Set default target
.DEFAULT_GOAL := help
