# ====================================================================
# Makefile for tasks in {{ role_name }}
#
# This Makefile provides targets for managing role tasks.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

# Task files
TASKS := $(wildcard *.yml)
TASK_NAMES = $(basename $(TASKS))

# Phony targets
.PHONY: all lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Lint task files
lint: ## Lint task files
	@echo "${GREEN}Linting task files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping${NC}"; \
	fi

# Format task files
format: ## Format task files
	@echo "${GREEN}Formatting task files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint --format=auto --fix . || true; \
	fi

# Clean task artifacts
clean: ## Clean task artifacts
	@echo "${YELLOW}Cleaning task artifacts...${NC}"
	@find . -type f -name "*.retry" -delete

# List available task files
list: ## List available task files
	@echo "${GREEN}Available task files:${NC}"
	@for task in $(TASKS); do \
		echo "- $$task"; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ role_name }} - Tasks Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
