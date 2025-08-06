# ====================================================================
# Makefile for Module Utilities in {{ collection_name }}
#
# This Makefile provides targets for managing module utilities in the collection.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Directories
MODULE_UTILS_DIR := .

# Find all Python utility files
UTIL_FILES := $(wildcard $(MODULE_UTILS_DIR)/*.py)
UTIL_NAMES = $(notdir $(basename $(UTIL_FILES)))

# Python interpreter
PYTHON ?= python3

# Phony targets
.PHONY: all test lint format clean help $(UTIL_NAMES)

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run tests for all utilities
test: $(UTIL_NAMES) ## Run tests for all utilities

# Lint all utilities
lint: ## Lint all utility files
	@echo "${GREEN}Linting module utilities...${NC}"
	@if command -v pylint >/dev/null; then \
		echo "${YELLOW}Running pylint...${NC}"; \
		pylint --disable=C0114,C0115,C0116 $(UTIL_FILES); \
	else \
		echo "${YELLOW}pylint not found, skipping Python linting${NC}"; \
	fi
	@if command -v mypy >/dev/null; then \
		echo "${YELLOW}Running mypy...${NC}"; \
		mypy $(UTIL_FILES); \
	else \
		echo "${YELLOW}mypy not found, skipping type checking${NC}"; \
	fi

# Format code
format: ## Format utility code
	@echo "${GREEN}Formatting module utilities...${NC}"
	@if command -v black >/dev/null; then \
		echo "${YELLOW}Running black...${NC}"; \
		black $(UTIL_FILES); \
	else \
		echo "${YELLOW}black not found, skipping code formatting${NC}"; \
	fi
	@if command -v isort >/dev/null; then \
		echo "${YELLOW}Running isort...${NC}"; \
		isort $(UTIL_FILES); \
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

# Individual utility targets
$(UTIL_NAMES):
	@echo "${GREEN}Testing utility: $@${NC}"
	@if [ -f "test_$@.py" ]; then \
		$(PYTHON) -m pytest -v test_$@.py; \
	else \
		echo "${YELLOW}No tests found for $@${NC}"; \
	fi

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ collection_name }} - Module Utilities Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
