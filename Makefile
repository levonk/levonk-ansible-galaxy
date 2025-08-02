# ====================================================================
# Root Makefile for levonk-ansible-galaxy
# This file forwards commands to the ansible-galaxy subdirectory
# ====================================================================

# Project Configuration
PROJECT_NAME := levonk-ansible-galaxy
BIN_DIR := $(shell pwd)/bin
VERSION := $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")
ANSIBLE_GALAXY_DIR := ansible-galaxy

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help list list-collections dev-beta debug-beta FORCE

# ====================================================================
# Default Target
# ====================================================================
.DEFAULT_GOAL := help

# Alias for default target
all: help

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mRoot Makefile - Available Targets\033[0m"
	@echo "=================================================="
	@echo "\n\033[1mCore Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 !~ /default|help-targets/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mAnsible Galaxy Targets:\033[0m"
	@cd $(ANSIBLE_GALAXY_DIR) && \
	$(MAKE) --no-print-directory help-targets 2>/dev/null || \
	echo "  (Run 'make' in the ansible-galaxy directory to see all targets)"
	@echo "\nFor more detailed help, run 'make help' in the ansible-galaxy directory."

# ====================================================================
# Collection Management
# ====================================================================

list list-collections: ## List available collections in the levonk namespace
	@echo "\n\033[1mAvailable Collections\033[0m"
	@echo "==================="
	@if [ -d "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk" ]; then \
		echo "Collections in levonk namespace:"; \
		ls -1 "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk" | sort; \
	else \
		echo "No collections found in $(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk"; \
	fi

# ====================================================================
# Development Targets
# ====================================================================

dev-beta: ## Development version of beta that skips token check
	@echo "Creating beta marker file for development purposes (skipping actual publishing)"
	@mkdir -p $(ANSIBLE_GALAXY_DIR)/.markers
	@touch $(ANSIBLE_GALAXY_DIR)/.markers/beta.marker

debug-beta: ## Debug Galaxy authentication issues
	@echo "=== Debugging Galaxy Authentication ==="
	@if [ -z "$${ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "WARNING: ANSIBLE_GALAXY_TOKEN is not set"; \
	else \
		echo "Token length: $${#ANSIBLE_GALAXY_TOKEN} characters"; \
		echo "Token prefix: $${ANSIBLE_GALAXY_TOKEN:0:3}..."; \
	fi
	@echo "\nChecking server connectivity..."
	@cd $(ANSIBLE_GALAXY_DIR) && GALAXY_SERVER="https://galaxy-dev.ansible.com" ANSIBLE_VERBOSITY=3 ansible-galaxy collection list --server="https://galaxy-dev.ansible.com"
	@echo "\nTrying with v3 API endpoint..."
	@curl -s -I -H "Authorization: Token $${ANSIBLE_GALAXY_TOKEN:-none}" "https://galaxy-dev.ansible.com/api/v3/" | head -n 1

# ====================================================================
# Target Forwarding
# ====================================================================

# Forward all other targets to the ansible-galaxy directory
%: FORCE
	@if [ -f "$(ANSIBLE_GALAXY_DIR)/Makefile" ]; then \
		cd $(ANSIBLE_GALAXY_DIR) && $(MAKE) $@; \
	else \
		echo "Error: $(ANSIBLE_GALAXY_DIR)/Makefile not found"; \
		exit 1; \
	fi

# ====================================================================
# Utility Targets
# ====================================================================

# Force target to always run commands
FORCE:

# ====================================================================
# Include common targets from subdirectories
# ====================================================================

# Include common makefile if it exists
-include common.mk
