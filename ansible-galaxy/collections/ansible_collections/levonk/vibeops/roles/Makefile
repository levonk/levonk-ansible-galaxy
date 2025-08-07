# ====================================================================
# Makefile for roles in levonk.vibeops
# 
# This Makefile provides targets for managing all roles within the
# levonk.vibeops collection, including testing, linting, and validation.
# ====================================================================

# --------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------
COLLECTION_NAME := vibeops
NAMESPACE := levonk
ROOT_DIR := $(shell git rev-parse --show-toplevel)

# Include common variables and functions
-include $(ROOT_DIR)/common.mk

# Get all role directories that contain a tasks directory
ROLE_DIRS := $(wildcard */tasks/..)
ROLE_NAMES := $(notdir $(ROLE_DIRS))

# ANSI color codes for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color
BOLD := \033[1m
RESET := \033[0m

# Phony targets
.PHONY: all help list test lint format clean $(ROLE_NAMES)

# --------------------------------------------------------------------
# Help
# --------------------------------------------------------------------
.DEFAULT_GOAL := help

help: ## Show this help
@echo "\n$(BOLD)Role Management for $(NAMESPACE).$(COLLECTION_NAME)$(RESET)"
@echo "\n$(BOLD)Available targets:$(RESET)"
@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-20s$(RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# --------------------------------------------------------------------
# Main Targets
# --------------------------------------------------------------------

# Default target
all: help

# List all available roles
list: ## List all available roles
@echo "$(BOLD)Available roles in $(NAMESPACE).$(COLLECTION_NAME):$(RESET)"
@for role in $(ROLE_NAMES); do \
echo "  - $$role"; \
done

# Run tests for all roles
test: $(addsuffix -test,$(ROLE_NAMES)) ## Test all roles

# Run linting for all roles
lint: $(addsuffix -lint,$(ROLE_NAMES)) ## Lint all roles

# Format all roles
format: $(addsuffix -format,$(ROLE_NAMES)) ## Format all roles

# Clean all roles
clean: $(addsuffix -clean,$(ROLE_NAMES)) ## Clean all roles

# --------------------------------------------------------------------
# Role-specific Targets
# --------------------------------------------------------------------

# Define pattern rules for role operations
%-test: ## Test a specific role
@if [ -d "$*" ]; then \
echo "$(BOLD)Testing role: $*$(RESET)"; \
$(MAKE) -C "$*" test || exit 1; \
else \
echo "$(RED)Error: Role '$*' not found$(RESET)"; \
exit 1; \
fi

%-lint: ## Lint a specific role
@if [ -d "$*" ]; then \
echo "$(BOLD)Linting role: $*$(RESET)"; \
$(MAKE) -C "$*" lint || exit 1; \
else \
echo "$(RED)Error: Role '$*' not found$(RESET)"; \
exit 1; \
fi

%-format: ## Format a specific role
@if [ -d "$*" ]; then \
echo "$(BOLD)Formatting role: $*$(RESET)"; \
$(MAKE) -C "$*" format || exit 1; \
else \
echo "$(RED)Error: Role '$*' not found$(RESET)"; \
exit 1; \
fi

%-clean: ## Clean a specific role
@if [ -d "$*" ]; then \
echo "$(BOLD)Cleaning role: $*$(RESET)"; \
$(MAKE) -C "$*" clean || exit 1; \
else \
echo "$(RED)Error: Role '$*' not found$(RESET)"; \
exit 1; \
fi

# Individual role targets (e.g., make developer)
$(ROLE_NAMES): %: %-test %-lint

# --------------------------------------------------------------------
# Helper Functions
# --------------------------------------------------------------------

# Check if a command exists
check_cmd = @command -v $1 >/dev/null 2>&1 || \
{ echo "$(RED)Error: $1 is required but not installed.$(RESET)" >&2; \
[ -n "$2" ] && echo "$(YELLOW)Hint: $2$(RESET)" >&2; \
exit 1; }
