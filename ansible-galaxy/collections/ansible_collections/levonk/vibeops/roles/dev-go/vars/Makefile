# ====================================================================
# Makefile for variables in {{ role_name }}
#
# This Makefile provides targets for managing role variables.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

# Variable files
VARS := $(wildcard *.yml)
VAR_NAMES = $(basename $(VARS))

# Phony targets
.PHONY: all lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Lint variable files
lint: ## Lint variable files
	@echo "${GREEN}Linting variable files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping${NC}"; \
	fi

# Format variable files
format: ## Format variable files
	@echo "${GREEN}Formatting variable files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint --format=auto --fix . || true; \
	fi

# Clean variable artifacts
clean: ## Clean variable artifacts
	@echo "${YELLOW}Cleaning variable artifacts...${NC}"
	@# No specific artifacts to clean

# List available variable files
list: ## List available variable files
	@echo "${GREEN}Available variable files:${NC}"
	@for var in $(VARS); do \
		echo "- $$var"; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ role_name }} - Variables Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
