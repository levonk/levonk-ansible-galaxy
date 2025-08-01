# ====================================================================
# vibeops Collection
# ====================================================================

# Collection-specific variables
COLLECTION_NAME := vibeops

# Calculate the path to the ansible-galaxy directory
ANSIBLE_GALAXY_DIR := $(shell cd $(dir $(lastword $(MAKEFILE_LIST)))/../../../.. && pwd)

# ====================================================================
# Include shared Makefiles
# ====================================================================

# Include the shared Makefile with all targets and variables
include $(ANSIBLE_GALAXY_DIR)/shared-targets.mk

# ====================================================================
# Collection-specific Targets
# ====================================================================

# Add collection-specific targets below this line
# Example:
# .PHONY: custom-target
# custom-target: ## Example custom target
#	@echo "Running custom target for $(COLLECTION_NAME)"
