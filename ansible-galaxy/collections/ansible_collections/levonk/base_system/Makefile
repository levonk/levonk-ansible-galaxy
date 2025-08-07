# ====================================================================
# Collection: base_system
# ====================================================================
# Makefile for Ansible collection collections.base_system
# This file includes shared targets and defines collection-specific targets.
# ====================================================================

# ====================================================================
# Include Common Variables
# ====================================================================
# Get the root directory (ansible-galaxy directory)
ANSIBLE_GALAXY_DIR := $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell pwd)))))
# Include common.mk if it exists
ifneq (,$(wildcard $(ANSIBLE_GALAXY_DIR)/common.mk))
include $(ANSIBLE_GALAXY_DIR)/common.mk
endif

# Collection name and paths
COLLECTION_NAME := $(shell grep -E '^name:' galaxy.yml | awk '{print $$2}')
COLLECTION_NAMESPACE := $(shell grep -E '^namespace:' galaxy.yml | awk '{print $$2}')
FULL_COLLECTION_NAME := $(COLLECTION_NAMESPACE).$(COLLECTION_NAME)
VERSION := $(shell grep -E '^version:' galaxy.yml | awk '{print $$2}')

# Project directories
PROJECT_ROOT := $(shell cd "$(shell dirname '$(shell pwd)')/../.." && pwd -P)
PROJECT_DIST_DIR := $(PROJECT_ROOT)/dist

# Build directories
BUILD_DIR ?= $(CURDIR)/.build
DIST_DIR ?= $(PROJECT_DIST_DIR)
COLLECTION_BUILD_DIR := $(BUILD_DIR)/$(FULL_COLLECTION_NAME)
COLLECTION_TARBALL := $(DIST_DIR)/$(FULL_COLLECTION_NAME)-$(VERSION).tar.gz

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Phony targets
.PHONY: all build clean test lint format new-role check-env check-tools version status

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Build the collection tarball (requires ANSIBLE_GALAXY_TOKEN)
build: check-env ## Build the collection tarball (requires ANSIBLE_GALAXY_TOKEN)
	@echo "${GREEN}Building $(FULL_COLLECTION_NAME) collection...${NC}"
	@mkdir -p $(DIST_DIR) $(BUILD_DIR)
	@rm -rf $(COLLECTION_BUILD_DIR)
	@mkdir -p $(COLLECTION_BUILD_DIR)
	@cp -r . $(COLLECTION_BUILD_DIR)/
	@find $(COLLECTION_BUILD_DIR) -type f -name "*.py[co]" -delete
	@find $(COLLECTION_BUILD_DIR) -type d -name "__pycache__" -exec rm -rf {} +
	@find $(COLLECTION_BUILD_DIR) -type d -name ".pytest_cache" -exec rm -rf {} +
	@ansible-galaxy collection build --output-path $(DIST_DIR) $(COLLECTION_BUILD_DIR)
	@echo "${GREEN}Collection built: $(DIST_DIR)/$(FULL_COLLECTION_NAME)-$(VERSION).tar.gz${NC}"

# Build the collection tarball locally (no token required)
local-build: ## Build the collection tarball locally (no token required)
	@echo "${GREEN}Building $(FULL_COLLECTION_NAME) collection locally...${NC}"
	@echo "${YELLOW}Project root: $(PROJECT_ROOT)${NC}"
	@echo "${YELLOW}Project dist dir: $(PROJECT_DIST_DIR)${NC}"
	
	# Create necessary directories
	@echo "${YELLOW}Creating necessary directories...${NC}"
	@mkdir -p "$(BUILD_DIR)" "$(PROJECT_DIST_DIR)" 2>/dev/null || true
	
	# Clean up existing tarballs
	@echo "${YELLOW}Cleaning up existing tarballs...${NC}"
	@rm -f "$(PROJECT_DIST_DIR)/$(FULL_COLLECTION_NAME)-"*.tar.gz 2>/dev/null || true
	
	# Prepare clean build directory
	@echo "${YELLOW}Preparing clean build directory...${NC}"
	@rm -rf "$(COLLECTION_BUILD_DIR)" 2>/dev/null || true
	@mkdir -p "$(COLLECTION_BUILD_DIR)"
	
	# Copy collection files
	@echo "${YELLOW}Copying collection files...${NC}"
	@find . -mindepth 1 -maxdepth 1 \
		-not -path "./$(BUILD_DIR)" \
		-not -path "./$(DIST_DIR)" \
		-not -path "./.*" \
		-exec cp -r {} "$(COLLECTION_BUILD_DIR)/" \; 2>/dev/null || true
	
	# Clean up temporary files
	@echo "${YELLOW}Cleaning up temporary files...${NC}"
	@find "$(COLLECTION_BUILD_DIR)" -type f -name "*.py[co]" -delete 2>/dev/null || true
	@find "$(COLLECTION_BUILD_DIR)" -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find "$(COLLECTION_BUILD_DIR)" -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	
	# Remove broken symlinks
	@echo "${YELLOW}Removing broken symlinks...${NC}"
	@find "$(COLLECTION_BUILD_DIR)" -type l ! -exec test -e {} \; -print0 | xargs -r -0 rm -f 2>/dev/null || true
	
	# Build the collection
	@echo "${YELLOW}Building collection tarball...${NC}"
	@echo "${YELLOW}Output directory: $(PROJECT_DIST_DIR)${NC}"
	@cd "$(COLLECTION_BUILD_DIR)" && \
	ansible-galaxy collection build --force --output-path "$(PROJECT_DIST_DIR)" .
	
	# Verify the tarball was created (handle both dotted and dashed filenames)
	@DASHED_NAME=`echo "$(FULL_COLLECTION_NAME)" | tr '.' '-'`; \
	if [ -f "$(PROJECT_DIST_DIR)/$(FULL_COLLECTION_NAME)-$(VERSION).tar.gz" ]; then \
		echo "${GREEN}Collection built successfully: $(PROJECT_DIST_DIR)/$(FULL_COLLECTION_NAME)-$(VERSION).tar.gz${NC}"; \
		echo "${YELLOW}To install this collection, run:${NC}"; \
		echo "ansible-galaxy collection install $(PROJECT_DIST_DIR)/$(FULL_COLLECTION_NAME)-$(VERSION).tar.gz -p ~/.ansible/collections"; \
		exit 0; \
	elif [ -f "$(PROJECT_DIST_DIR)/$$DASHED_NAME-$(VERSION).tar.gz" ]; then \
		echo "${GREEN}Collection built successfully: $(PROJECT_DIST_DIR)/$$DASHED_NAME-$(VERSION).tar.gz${NC}"; \
		echo "${YELLOW}To install this collection, run:${NC}"; \
		echo "ansible-galaxy collection install $(PROJECT_DIST_DIR)/$$DASHED_NAME-$(VERSION).tar.gz -p ~/.ansible/collections"; \
		exit 0; \
	else \
		echo "${RED}Failed to build collection: Tarball not found in $(PROJECT_DIST_DIR)${NC}"; \
		echo "${YELLOW}Contents of $(PROJECT_DIST_DIR):${NC}"; \
		ls -la "$(PROJECT_DIST_DIR)" || true; \
		echo "${YELLOW}Looking for: $(FULL_COLLECTION_NAME)-$(VERSION).tar.gz or $$DASHED_NAME-$(VERSION).tar.gz${NC}"; \
		echo "${YELLOW}Current directory: $(shell pwd)${NC}"; \
		echo "${YELLOW}Project root: $(PROJECT_ROOT)${NC}"; \
		echo "${YELLOW}Project dist dir: $(PROJECT_DIST_DIR)${NC}"; \
		exit 1; \
	fi

# Clean build artifacts
clean: ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${NC}"
	@rm -rf $(BUILD_DIR) $(DIST_DIR)
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +
	@echo "${GREEN}Clean complete.${NC}"

# ====================================================================
# Test & Lint Targets
# ====================================================================

test: check-tools ## Run tests for the collection
	@echo "${GREEN}Running tests for $(FULL_COLLECTION_NAME)...${NC}"
	@if [ -d "tests" ]; then \
		ansible-test sanity --docker default; \
		ansible-test units --docker default; \
	else \
		echo "${YELLOW}No tests directory found.${NC}"; \
	fi

lint: check-tools ## Run linters on the collection
	@echo "${GREEN}Running linters on $(FULL_COLLECTION_NAME)...${NC}"
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

format: ## Format code in the collection
	@echo "${GREEN}Formatting code in $(FULL_COLLECTION_NAME)...${NC}"
	@if command -v yamllint >/dev/null; then \
		echo "${YELLOW}Formatting YAML files...${NC}"; \
		find . -name '*.yml' -o -name '*.yaml' | xargs yamllint --format=auto --fix || true; \
	fi
	@echo "${GREEN}Formatting complete.${NC}"

# ====================================================================
# Development Targets
# ====================================================================

new-role: ## Create a new role in this collection
	@read -p "Enter role name: " role_name; \
	if [ -z "$$role_name" ]; then \
		echo "${RED}Error: Role name cannot be empty${NC}"; \
		exit 1; \
	fi; \
	if [ -d "roles/$$role_name" ]; then \
		echo "${RED}Error: Role '$$role_name' already exists${NC}"; \
		exit 1; \
	fi; \
	echo "${GREEN}Creating new role: $$role_name${NC}"; \
	mkdir -p "roles/$$role_name"; \
	cd "roles/$$role_name" && ansible-galaxy role init $$role_name; \
	echo "${GREEN}Role created at: roles/$$role_name${NC}"

# ====================================================================
# Utility Functions
# ====================================================================

check-env: ## Check if required environment variables are set
	@if [ -z "$(ANSIBLE_GALAXY_TOKEN)" ]; then \
		echo "${RED}Error: ANSIBLE_GALAXY_TOKEN is not set${NC}"; \
		exit 1; \
	fi

check-tools: ## Check if required tools are installed
	@command -v ansible >/dev/null 2>&1 || { echo "${RED}Error: ansible is not installed${NC}" >&2; exit 1; }
	@command -v ansible-galaxy >/dev/null 2>&1 || { echo "${RED}Error: ansible-galaxy is not installed${NC}" >&2; exit 1; }
	@command -v ansible-test >/dev/null 2>&1 || { echo "${YELLOW}Warning: ansible-test is not installed, some tests may fail${NC}" >&2; }

version: ## Show version information
	@echo "${GREEN}$(FULL_COLLECTION_NAME) Version Information${NC}"
	@echo "===================================="
	@echo "Collection: $(FULL_COLLECTION_NAME)"
	@if [ -f "galaxy.yml" ]; then \
		echo "Version: $$(grep '^version:' galaxy.yml | awk '{print $$2}')"; \
	else \
		echo "${YELLOW}Warning: galaxy.yml not found${NC}"; \
	fi

status: ## Show status of the collection
	@echo "${GREEN}$(FULL_COLLECTION_NAME) Status${NC}"
	@echo "========================"
	@echo "Roles:"
	@if [ -d "roles" ]; then \
		for role in $$(find roles -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort); do \
			echo "- $$role"; \
		done; \
	else \
		echo "No roles found"; \
	fi

# ====================================================================
# Help Target (must be last to capture all targets)
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m$(FULL_COLLECTION_NAME) - Available Targets\033[0m"
	@echo "========================================"
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-20s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
