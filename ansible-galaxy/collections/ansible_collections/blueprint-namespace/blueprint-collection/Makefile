# ====================================================================
# Collection: {{ collection_name }}
# ====================================================================
# Makefile for Ansible collection {{ namespace_name }}.{{ collection_name }}
# This file includes shared targets and defines collection-specific targets.
# ====================================================================

# ====================================================================
# Include Shared Makefile
# ====================================================================
ANSIBLE_GALAXY_DIR := $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell pwd)))))
include $(ANSIBLE_GALAXY_DIR)/shared-targets.mk

# ====================================================================
# Collection-specific Variables
# ====================================================================
# Most variables are defined in shared-targets.mk
# Add any collection-specific variables below

# ====================================================================
# Collection-specific Targets
# ====================================================================
# Most common targets are now in shared-targets.mk
# Add any collection-specific targets below this line

# ====================================================================
# Collection-specific Development Targets
# ====================================================================
# The watch target is defined in shared-targets.mk
# Override it here if you need collection-specific behavior

new-role: ## Create a new role in this collection
	@read -p "Enter role name: " role_name; \
	if [ -z "$$role_name" ]; then \
		echo "Error: Role name cannot be empty"; \
		exit 1; \
	fi; \
	mkdir -p "roles/$$role_name"; \
	echo "Created new role: roles/$$role_name"; \
	# Initialize role structure
	cd "roles/$$role_name" && ansible-galaxy role init $$role_name
