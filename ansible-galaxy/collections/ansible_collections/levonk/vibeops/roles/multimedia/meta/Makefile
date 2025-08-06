# ====================================================================
# Makefile for metadata in {{ role_name }}
#
# This Makefile provides targets for managing role metadata.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

# Metadata files
METADATA := $(wildcard *.yml)
METADATA_NAMES = $(basename $(METADATA))

# Phony targets
.PHONY: all lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Lint metadata files
lint: ## Lint metadata files
	@echo "${GREEN}Linting metadata files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping${NC}"; \
	fi
	@if command -v ansible-lint >/dev/null; then \
		ansible-lint -v .; \
	else \
		echo "${YELLOW}ansible-lint not found, skipping${NC}"; \
	fi

# Format metadata files
format: ## Format metadata files
	@echo "${GREEN}Formatting metadata files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint --format=auto --fix . || true; \
	fi

# Clean metadata artifacts
clean: ## Clean metadata artifacts
	@echo "${YELLOW}Cleaning metadata artifacts...${NC}"
	@# No specific artifacts to clean

# List available metadata files
list: ## List available metadata files
	@echo "${GREEN}Available metadata files:${NC}"
	@for meta in $(METADATA); do \
		echo "- $$meta"; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ role_name }} - Metadata Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
