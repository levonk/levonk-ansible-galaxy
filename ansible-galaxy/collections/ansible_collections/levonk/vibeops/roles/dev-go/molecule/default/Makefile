# ====================================================================
# Makefile for Molecule tests in {{ role_name }}
#
# This Makefile provides targets for managing Molecule tests.
# ====================================================================

# Include common variables
-inline ../../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Molecule configuration
MOLECULE_IMAGE ?= quay.io/ansible/molecule:latest

# Phony targets
.PHONY: all test create converge verify destroy lint clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run full test sequence
test: create converge verify destroy ## Run full test sequence

# Create test environment
create: ## Create test environment
	@echo "${GREEN}Creating test environment...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule create; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) create; \
	fi

# Run converge step
converge: ## Run converge step
	@echo "${GREEN}Running converge...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule converge; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) converge; \
	fi

# Run verify step
verify: ## Run verify step
	@echo "${GREEN}Running verify...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule verify; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) verify; \
	fi

# Run destroy step
destroy: ## Run destroy step
	@echo "${YELLOW}Destroying test environment...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule destroy; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \n			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) destroy; \
	fi

# Lint test files
lint: ## Lint test files
	@echo "${GREEN}Linting test files...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule lint; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) lint; \
	fi

# Clean test artifacts
clean: destroy ## Clean test artifacts
	@echo "${YELLOW}Cleaning test artifacts...${NC}"
	@rm -rf .molecule .pytest_cache

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ role_name }} - Molecule Test Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
