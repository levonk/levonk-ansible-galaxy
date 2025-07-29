# Root Makefile for levonk-ansible-galaxy
# This file forwards commands to the ansible-galaxy subdirectory

# Define the subdirectory containing the actual Makefile
ANSIBLE_GALAXY_DIR := ansible-galaxy

# Default target
.PHONY: all
all:
	@echo "Forwarding to $(ANSIBLE_GALAXY_DIR)/Makefile"
	@cd $(ANSIBLE_GALAXY_DIR) && $(MAKE) all

# Forward common targets
.PHONY: clean build test lint beta prod reset inst-beta inst-prod molecule lint-ansible lint-markdown lint-yaml lint-galaxy new-collection new-role debug
clean build test lint beta prod reset inst-beta inst-prod molecule lint-ansible lint-markdown lint-yaml lint-galaxy new-collection new-role debug:
	@echo "Forwarding '$@' target to $(ANSIBLE_GALAXY_DIR)/Makefile"
	@cd $(ANSIBLE_GALAXY_DIR) && $(MAKE) $@

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
	@cd $(ANSIBLE_GALAXY_DIR) && $(MAKE) list

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all      - Default target, builds all collections"
	@echo "  clean    - Clean build artifacts"
	@echo "  build    - Build all collections"
	@echo "  dev-beta - Development version of beta that skips token check"
	@echo "  test     - Run tests on all collections"
	@echo "  lint     - Run linting on all collections"
	@echo "  beta     - Publish to beta server"
	@echo "  prod     - Publish to production server"
	@echo "  list     - List available collections"
	@echo "  reset    - Reset all markers to force full rebuild"
	@echo "  help     - Show this help message"
