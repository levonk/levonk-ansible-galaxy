# ====================================================================
# gamer Collection
# ====================================================================

# Collection-specific variables
COLLECTION_NAME := gamer

# Calculate the path to the ansible-galaxy directory
ANSIBLE_GALAXY_DIR := $(shell cd $(dir $(lastword $(MAKEFILE_LIST)))/../../../.. && pwd)

# ====================================================================
# Include shared Makefiles
# ====================================================================

# Include shared Makefile from the ansible-galaxy directory
include $(ANSIBLE_GALAXY_DIR)/shared.mk

# Include the shared targets (build, test, lint, etc.)
include $(ANSIBLE_GALAXY_DIR)/shared-targets.mk

# ====================================================================
# Collection-specific Targets
# ====================================================================

# Add collection-specific targets below this line
# Example:
# .PHONY: custom-target
# custom-target: ## Example custom target
#	@echo "Running custom target for $(COLLECTION_NAME)"
