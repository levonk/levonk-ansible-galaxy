# ====================================================================
# Makefile for Ansible Role: {{ role_name }}
#
# This Makefile provides targets for managing the {{ role_name }} role,
# including testing with Molecule, linting, and documentation.
# ====================================================================

# Include common variables
-inline ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Role variables
ROLE_NAME := $(notdir $(CURDIR))
MOLECULE_IMAGE ?= quay.io/ansible/molecule:latest

# Phony targets
.PHONY: help test lint format clean molecule-test molecule-converge molecule-verify molecule-destroy

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Test role with Molecule
test: molecule-test ## Test role with Molecule (alias for molecule-test)

# Lint role files
lint: ## Lint role files
	@echo "${GREEN}Linting ${ROLE_NAME} role...${NC}"
	@if command -v ansible-lint >/dev/null; then \
		ansible-lint -v .; \
	else \
		echo "${YELLOW}ansible-lint not found, skipping${NC}"; \
	fi
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping${NC}"; \
	fi

# Format role files
format: ## Format role files
	@echo "${GREEN}Formatting ${ROLE_NAME} role files...${NC}"
	@if command -v yamllint >/dev/null; then \
		find . -name '*.yml' -o -name '*.yaml' | xargs yamllint --format=auto --fix || true; \
	fi

# Clean role artifacts
clean: molecule-destroy ## Clean role artifacts
	@echo "${YELLOW}Cleaning ${ROLE_NAME} role artifacts...${NC}"
	@rm -rf .molecule .pytest_cache
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete

# ====================================================================
# Molecule Targets
# ====================================================================

# Run Molecule tests
molecule-test: ## Run Molecule tests
	@echo "${GREEN}Running Molecule tests for ${ROLE_NAME}...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule test; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) test; \
	fi

# Run Molecule converge
molecule-converge: ## Run Molecule converge
	@echo "${GREEN}Running Molecule converge for ${ROLE_NAME}...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule converge; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) converge; \
	fi

# Run Molecule verify
molecule-verify: ## Run Molecule verify
	@echo "${GREEN}Running Molecule verify for ${ROLE_NAME}...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule verify; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) verify; \
	fi

# Run Molecule destroy
molecule-destroy: ## Run Molecule destroy
	@echo "${YELLOW}Destroying Molecule environment for ${ROLE_NAME}...${NC}"
	@if command -v molecule >/dev/null; then \
		molecule destroy; \
	else \
		docker run --rm -it \
			-v $(CURDIR):/tmp/$(ROLE_NAME) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-w /tmp/$(ROLE_NAME) \
			$(MOLECULE_IMAGE) destroy; \
	fi

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m${ROLE_NAME} - Ansible Role\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-20s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
