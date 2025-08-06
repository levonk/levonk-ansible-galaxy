# ====================================================================
# Makefile for playbooks in {{ namespace_name }}.{{ collection_name }}
#
# This Makefile provides targets for managing playbooks within the
# collection, including validation, testing, and execution.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Playbook files
PLAYBOOKS := $(wildcard *.yml) $(wildcard *.yaml)
PLAYBOOK_NAMES = $(basename $(PLAYBOOKS))

# Phony targets
.PHONY: all test lint format clean help list

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Validate playbooks
validate: ## Validate playbook syntax
	@echo "${GREEN}Validating playbooks...${NC}"
	@for playbook in $(PLAYBOOKS); do \
		echo "${YELLOW}Validating $${playbook}...${NC}"; \
		ansible-playbook --syntax-check $${playbook} || exit 1; \
	done

# Test playbooks (dry-run)
test: ## Run playbooks in check mode (dry-run)
	@echo "${GREEN}Testing playbooks in check mode...${NC}"
	@for playbook in $(PLAYBOOKS); do \
		echo "${YELLOW}Testing $${playbook}...${NC}"; \
		ansible-playbook --check --diff $${playbook} || exit 1; \
	done

# Lint playbooks
lint: ## Lint all playbooks
	@echo "${GREEN}Running linters on playbooks...${NC}"
	@if command -v yamllint >/dev/null; then \
		echo "${YELLOW}Running yamllint...${NC}"; \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping YAML linting${NC}"; \
	fi
	@if command -v ansible-lint >/dev/null; then \
		echo "${YELLOW}Running ansible-lint...${NC}"; \
		ansible-lint -v; \
	else \
		echo "${YELLOW}ansible-lint not found, skipping Ansible linting${NC}"; \
	fi

# Format playbooks
format: ## Format playbook YAML files
	@echo "${GREEN}Formatting playbooks...${NC}"
	@if command -v yamllint >/dev/null; then \
		echo "${YELLOW}Formatting YAML files...${NC}"; \
		find . -name '*.yml' -o -name '*.yaml' | xargs yamllint --format=auto --fix || true; \
	fi
	@echo "${GREEN}Formatting complete.${NC}"

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${NC}"
	@find . -type f -name "*.retry" -delete
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# List available playbooks
list: ## List all available playbooks
	@echo "${GREEN}Available playbooks in {{ namespace_name }}.{{ collection_name }}:${NC}"
	@echo "======================================"
	@for playbook in $(PLAYBOOKS); do \
		echo "- $$playbook"; \
	done

# Individual playbook targets
$(PLAYBOOK_NAMES): %: %.yml
	@echo "${GREEN}Running playbook: $<${NC}"
	ansible-playbook $<

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ namespace_name }}.{{ collection_name }} - Playbooks Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mAvailable Playbooks\033[0m"
	@echo "------------------"
	@for playbook in $(PLAYBOOK_NAMES); do \
		echo "  make $${playbook}"; \
	done

# Set default target
.DEFAULT_GOAL := help
