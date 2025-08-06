# ====================================================================
# Makefile for module_utils in {{ namespace_name }}.{{ collection_name }}
#
# This Makefile provides targets for managing module utilities used by
# the collection's modules, including testing, validation, and documentation.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Module utility files
UTILS := $(wildcard *.py)
UTIL_NAMES = $(basename $(UTILS))

# Phony targets
.PHONY: all test lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Test module utilities
test: ## Test all module utilities
	@echo "${GREEN}Testing module utilities...${NC}"
	@if [ -d "tests" ]; then \
		cd tests && $(MAKE) test; \
	else \
		echo "${YELLOW}No tests directory found.${NC}"; \
	fi

# Lint module utilities
lint: ## Lint all module utilities
	@echo "${GREEN}Running linters on module utilities...${NC}"
	@if command -v pylint >/dev/null; then \
		echo "${YELLOW}Running pylint...${NC}"; \
		pylint --disable=C0114,C0115,C0116 $(UTILS); \
	else \
		echo "${YELLOW}pylint not found, skipping Python linting${NC}"; \
	fi
	@if command -v mypy >/dev/null; then \
		echo "${YELLOW}Running mypy...${NC}"; \
		mypy $(UTILS); \
	else \
		echo "${YELLOW}mypy not found, skipping type checking${NC}"; \
	fi

# Format code
format: ## Format module utility code
	@echo "${GREEN}Formatting module utility code...${NC}"
	@if command -v black >/dev/null; then \
		echo "${YELLOW}Formatting with black...${NC}"; \
		black $(UTILS); \
	else \
		echo "${YELLOW}black not found, skipping code formatting${NC}"; \
	fi
	@if command -v isort >/dev/null; then \
		echo "${YELLOW}Sorting imports with isort...${NC}"; \
		isort $(UTILS); \
	else \
		echo "${YELLOW}isort not found, skipping import sorting${NC}"; \
	fi

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${NC}"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".mypy_cache" -exec rm -rf {} +
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# List available module utilities
list: ## List all available module utilities
	@echo "${GREEN}Available module utilities in {{ namespace_name }}.{{ collection_name }}:${NC}"
	@echo "======================================"
	@for util in $(UTILS); do \
		echo "- $$util"; \
	done

# Individual utility targets
$(UTIL_NAMES): %: %.py
	@echo "${GREEN}Testing module utility: $<${NC}"
	@if [ -f "tests/test_$<" ]; then \
		python -m pytest "tests/test_$<"; \
	else \
		echo "${YELLOW}No tests found for $<${NC}"; \
	fi

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ namespace_name }}.{{ collection_name }} - Module Utilities Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mAvailable Module Utilities\033[0m"
	@echo "-------------------------"
	@for util in $(UTIL_NAMES); do \
		echo "  make $${util}"; \
	done

# Set default target
.DEFAULT_GOAL := help
