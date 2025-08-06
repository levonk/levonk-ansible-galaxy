# ====================================================================
# Makefile for handlers in {{ role_name }}
#
# This Makefile provides targets for managing role handlers.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

# Handler files
HANDLERS := $(wildcard *.yml)
HANDLER_NAMES = $(basename $(HANDLERS))

# Phony targets
.PHONY: all lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Lint handler files
lint: ## Lint handler files
	@echo "${GREEN}Linting handler files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping${NC}"; \
	fi

# Format handler files
format: ## Format handler files
	@echo "${GREEN}Formatting handler files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint --format=auto --fix . || true; \
	fi

# Clean handler artifacts
clean: ## Clean handler artifacts
	@echo "${YELLOW}Cleaning handler artifacts...${NC}"
	@find . -type f -name "*.retry" -delete

# List available handler files
list: ## List available handler files
	@echo "${GREEN}Available handler files:${NC}"
	@for handler in $(HANDLERS); do \
		echo "- $$handler"; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ role_name }} - Handlers Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
