# ====================================================================
# Root Makefile for levonk-ansible-galaxy
# This file forwards commands to the ansible-galaxy subdirectory
# ====================================================================

# Define the subdirectory containing the actual Makefile
ANSIBLE_GALAXY_DIR := ansible-galaxy

# ====================================================================
# Default Target
# ====================================================================

# Default target when running just 'make'
.PHONY: default
.DEFAULT_GOAL := test

default: test

# Alias for default target
.PHONY: all
all: test

# ====================================================================
# Target Forwarding
# ====================================================================

# ====================================================================
# Local Targets (handled in root Makefile)
# ====================================================================

# List available collections (handled locally)
.PHONY: list list-collections
list list-collections:
	@echo "\n\033[1mAvailable Collections\033[0m"
	@echo "==================="
	@if [ -d "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk" ]; then \
		echo "Collections in levonk namespace:"; \
		ls -1 "$(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk" | sort; \
	else \
		echo "No collections found in $(ANSIBLE_GALAXY_DIR)/collections/ansible_collections/levonk"; \
	fi

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

# Special handling for help to show both root and subdirectory help
.PHONY: help
help: FORCE
	@echo "\n\033[1mRoot Makefile - Available Targets\033[0m"
	@echo "================================================="
	@echo "  help            - Show this help message"
	@echo "  list            - List available collections"
	@echo "  list-collections - Alias for list"
	@echo "  dev-beta        - Development version of beta that skips token check"
	@echo "  debug-beta      - Debug Galaxy authentication issues"
	@echo "\n\033[1mForwarding to ansible-galaxy/Makefile for additional targets\033[0m"
	@if [ -f "$(ANSIBLE_GALAXY_DIR)/Makefile" ]; then \
		cd $(ANSIBLE_GALAXY_DIR) && $(MAKE) --no-print-directory help; \
	else \
		echo "Warning: $(ANSIBLE_GALAXY_DIR)/Makefile not found"; \
	fi



# ====================================================================
# Special Targets
# ====================================================================

# Development beta target (skips token check)
.PHONY: dev-beta
dev-beta: build test
	@echo "Creating beta marker file for development purposes (skipping actual publishing)"
	@mkdir -p $(ANSIBLE_GALAXY_DIR)/.markers
	@touch $(ANSIBLE_GALAXY_DIR)/.markers/beta.marker

# Debug beta target for troubleshooting authentication issues
.PHONY: debug-beta
debug-beta:
	@echo "=== Debugging Galaxy Authentication ==="
	@echo "Token length: $$(echo $${ANSIBLE_GALAXY_TOKEN} | wc -c) characters"
	@echo "Token prefix: $$(echo $${ANSIBLE_GALAXY_TOKEN} | cut -c1-3)..."
	@echo "Checking server connectivity..."
	@cd $(ANSIBLE_GALAXY_DIR) && GALAXY_SERVER="https://galaxy-dev.ansible.com" ANSIBLE_VERBOSITY=3 ansible-galaxy collection list --server="https://galaxy-dev.ansible.com"
	@echo "\nTrying with v3 API endpoint..."
	@curl -s -I -H "Authorization: Token $${ANSIBLE_GALAXY_TOKEN}" "https://galaxy-dev.ansible.com/api/v3/" | head -n 1

# List available collections
.PHONY: list
list:
	@if [ -f "$(ANSIBLE_GALAXY_DIR)/Makefile" ]; then \
		cd $(ANSIBLE_GALAXY_DIR) && $(MAKE) --no-print-directory list; \
	else \
		echo "Error: $(ANSIBLE_GALAXY_DIR)/Makefile not found"; \
		exit 1; \
	fi

# Force target to always run commands
.PHONY: FORCE
FORCE:
	@echo "  lint     - Run linting on all collections"
	@echo "  beta     - Publish to beta server"
	@echo "  prod     - Publish to production server"
	@echo "  list     - List available collections"
	@echo "  reset    - Reset all markers to force full rebuild"
	@echo "  help     - Show this help message"
