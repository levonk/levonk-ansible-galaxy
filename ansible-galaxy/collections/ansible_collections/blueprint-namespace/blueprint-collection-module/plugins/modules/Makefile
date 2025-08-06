# ====================================================================
# Makefile for Ansible Modules in {{ collection_name }}
#
# This Makefile provides targets for managing Ansible modules in the collection.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Directories
MODULES_DIR := .

# Find all Python module files
MODULE_FILES := $(wildcard $(MODULES_DIR)/*.py)
MODULE_NAMES = $(notdir $(basename $(MODULE_FILES)))

# Python interpreter
PYTHON ?= python3

# Phony targets
.PHONY: all test lint format clean help $(MODULE_NAMES)

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run tests for all modules
test: $(MODULE_NAMES) ## Run tests for all modules

# Lint all modules
lint: ## Lint all modules
	@echo "${GREEN}Linting modules...${NC}"
	@if command -v pylint >/dev/null; then \
		echo "${YELLOW}Running pylint...${NC}"; \
		pylint --disable=C0114,C0115,C0116 $(MODULE_FILES); \
	else \
		echo "${YELLOW}pylint not found, skipping Python linting${NC}"; \
	fi

# Format code
format: ## Format module code
	@echo "${GREEN}Formatting modules...${NC}"
	@if command -v black >/dev/null; then \
		echo "${YELLOW}Running black...${NC}"; \
		black $(MODULE_FILES); \
	else \
		echo "${YELLOW}black not found, skipping code formatting${NC}"; \
	fi
	@if command -v isort >/dev/null; then \
		echo "${YELLOW}Running isort...${NC}"; \
		isort $(MODULE_FILES); \
	else \
		echo "${YELLOW}isort not found, skipping import sorting${NC}"; \
	fi

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${NC}"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +
	@find . -type d -name ".mypy_cache" -exec rm -rf {} +

# Generate documentation for all modules
docs: ## Generate documentation for all modules
	@for module in $(MODULE_NAMES); do \
		echo "${GREEN}Generating docs for $$module...${NC}"; \
		if command -v ansible-doc >/dev/null; then \
			ansible-doc -t module $$module || true; \
		else \
			echo "${YELLOW}ansible-doc not found, skipping documentation generation for $$module${NC}"; \
		fi; \
	done

# Individual module targets
$(MODULE_NAMES):
	@echo "${GREEN}Testing module: $@${NC}"
	@if [ -f "test_$@.py" ]; then \
		$(PYTHON) -m pytest -v test_$@.py; \
	else \
		echo "${YELLOW}No tests found for $@${NC}"; \
	fi

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ collection_name }} - Modules Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
