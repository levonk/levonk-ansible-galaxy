# ====================================================================
# Makefile for roles in levonk.server_llmchat
#
# This Makefile provides targets for managing roles within the server_llmchat
# collection. It automates common tasks like testing, linting, and documentation
# generation for all roles in the collection.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Get list of all roles in the collection
ROLES := $(notdir $(wildcard *))

# Phony targets
.PHONY: all test lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Test all roles
test: ## Run tests for all roles
	@echo "${GREEN}Running tests for all roles...${NC}"
	@for role in $(ROLES); do \
		if [ -d "$$role" ] && [ -f "$$role/Makefile" ]; then \
			echo "\n${GREEN}Testing role: $$role${NC}"; \
			$(MAKE) -C "$$role" test || exit 1; \
		elif [ -d "$$role" ]; then \
			echo "\n${YELLOW}No Makefile found for role: $$role${NC}"; \
		fi; \
	done

# Lint all roles
lint: ## Run linters on all roles
	@echo "${GREEN}Running linters on all roles...${NC}"
	@for role in $(ROLES); do \
		if [ -d "$$role" ] && [ -f "$$role/Makefile" ]; then \
			echo "\n${GREEN}Linting role: $$role${NC}"; \
			$(MAKE) -C "$$role" lint || exit 1; \
		elif [ -d "$$role" ]; then \
			echo "\n${YELLOW}No Makefile found for role: $$role${NC}"; \
		fi; \
	done

# Format code in all roles
format: ## Format code in all roles
	@echo "${GREEN}Formatting code in all roles...${NC}"
	@for role in $(ROLES); do \
		if [ -d "$$role" ] && [ -f "$$role/Makefile" ]; then \
			echo "\n${GREEN}Formatting role: $$role${NC}"; \
			$(MAKE) -C "$$role" format || true; \
		elif [ -d "$$role" ]; then \
			echo "\n${YELLOW}No Makefile found for role: $$role${NC}"; \
		fi; \
	done

# Clean build artifacts
clean: ## Clean build artifacts for all roles
	@echo "${YELLOW}Cleaning build artifacts for all roles...${NC}"
	@for role in $(ROLES); do \
		if [ -d "$$role" ] && [ -f "$$role/Makefile" ]; then \
			echo "\n${YELLOW}Cleaning role: $$role${NC}"; \
			$(MAKE) -C "$$role" clean || true; \
		elif [ -d "$$role" ]; then \
			echo "\n${YELLOW}No Makefile found for role: $$role${NC}"; \
		fi; \
	done

# List all roles
list: ## List all available roles
	@echo "${GREEN}Available roles in server_llmchat collection:${NC}"
	@echo "======================================"
	@for role in $(ROLES); do \
		if [ -d "$$role" ]; then \
			echo "- $$role"; \
		fi; \
	done

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mlevonk.server_llmchat - Roles Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\nRun 'make <target> ROLE=<role_name>' to operate on a specific role"

# Set default target
.DEFAULT_GOAL := help
