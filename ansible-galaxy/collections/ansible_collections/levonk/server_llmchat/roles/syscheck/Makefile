# ====================================================================
# Makefile for syscheck role in levonk.server_llmchat
#
# This Makefile provides targets for managing the syscheck role,
# including testing, linting, and documentation generation.
# ====================================================================

# Include common variables
-include ../../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Role name (auto-detected from directory name)
ROLE_NAME := $(notdir $(CURDIR))

# Molecule configuration
MOLECULE_IMAGE ?= quay.io/ansible/molecule:latest
MOLECULE_CMD ?= molecule

# Phony targets
.PHONY: all test lint format clean help molecule-docker

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run tests for this role
test: lint molecule-test ## Run all tests (lint + molecule)

# Lint the role
lint: ## Lint the role
	@echo "${GREEN}Linting ${ROLE_NAME} role...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping YAML linting${NC}"; \
	fi
	@if command -v ansible-lint >/dev/null; then \
		ansible-lint -v; \
	else \
		echo "${YELLOW}ansible-lint not found, skipping Ansible linting${NC}"; \
	fi

# Format the role files
format: ## Format role files
	@echo "${GREEN}Formatting ${ROLE_NAME} role...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint --format=auto --fix . || true; \
	fi

# Clean build artifacts
clean: molecule-clean ## Clean build artifacts
	@echo "${YELLOW}Cleaning ${ROLE_NAME} role artifacts...${NC}"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +

# ====================================================================
# Molecule Targets
# ====================================================================

# Run molecule tests (using local molecule if available, otherwise Docker)
molecule-test: check-molecule
	@if command -v $(MOLECULE_CMD) >/dev/null; then \
		echo "${GREEN}Running molecule tests locally...${NC}"; \
		$(MOLECULE_CMD) test; \
	else \
		echo "${YELLOW}molecule not found, using Docker...${NC}"; \
		$(MAKE) molecule-docker; \
	fi

# Run molecule tests using Docker
molecule-docker: check-docker
	@echo "${GREEN}Running molecule tests in Docker...${NC}"
	@docker run --rm -it \
		-v $(CURDIR):/tmp/$(ROLE_NAME) \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-w /tmp/$(ROLE_NAME) \
		$(MOLECULE_IMAGE) test

# Clean molecule artifacts
molecule-clean:
	@if command -v $(MOLECULE_CMD) >/dev/null; then \
		echo "${YELLOW}Cleaning molecule artifacts...${NC}"; \
		$(MOLECULE_CMD) destroy || true; \
		rm -rf molecule/default/.molecule; \
	fi

# ====================================================================
# Helper Targets
# ====================================================================

# Check if molecule is installed
check-molecule:
	@if ! command -v $(MOLECULE_CMD) >/dev/null && ! command -v docker >/dev/null; then \
		echo "${RED}Error: Neither molecule nor Docker is installed${NC}"; \
		echo "Install with: pip install molecule molecule-plugins[docker]"; \
		exit 1; \
	fi

# Check if Docker is installed
check-docker:
	@if ! command -v docker >/dev/null; then \
		echo "${RED}Error: Docker is not installed${NC}"; \
		echo "Install Docker from: https://docs.docker.com/get-docker/"; \
		exit 1; \
	fi

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mlevonk.server_llmchat - ${ROLE_NAME} Role\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-20s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
