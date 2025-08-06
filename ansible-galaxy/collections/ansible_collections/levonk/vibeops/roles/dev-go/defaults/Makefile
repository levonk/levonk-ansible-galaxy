# ====================================================================
# Makefile for defaults in {{ role_name }}
#
# This Makefile provides targets for managing role default variables.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

# Default variable files
DEFAULTS := $(wildcard *.yml)
DEFAULT_NAMES = $(basename $(DEFAULTS))

# Phony targets
.PHONY: all lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Lint default variable files
lint: ## Lint default variable files
	@echo "${GREEN}Linting default variable files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping${NC}"; \
	fi

# Format default variable files
format: ## Format default variable files
	@echo "${GREEN}Formatting default variable files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint --format=auto --fix . || true; \
	fi

# Clean default variable artifacts
clean: ## Clean default variable artifacts
	@echo "${YELLOW}Cleaning default variable artifacts...${NC}"
	@# No specific artifacts to clean

# List available default variable files
list: ## List available default variable files
	@echo "${GREEN}Available default variable files:${NC}"
	@for default in $(DEFAULTS); do \
		echo "- $$default"; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ role_name }} - Default Variables Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
