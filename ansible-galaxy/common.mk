# common.mk - Shared variables and settings for all Makefiles
# This file is included by all Makefiles in the hierarchy

# Base directories
ROOT_DIR := $(shell cd $(dir $(lastword $(MAKEFILE_LIST)))/.. && pwd)
COLLECTIONS_DIR := $(ROOT_DIR)/collections/ansible_collections/levonk
DIST_DIR := $(ROOT_DIR)/../dist

# Marker directory for tracking completed tasks
MARKER_DIR := $(ROOT_DIR)/.markers
CLEAN_MARKER := $(MARKER_DIR)/clean.marker
LINT_MARKER := $(MARKER_DIR)/lint.marker
BUILD_MARKER := $(MARKER_DIR)/build.marker
TEST_MARKER := $(MARKER_DIR)/test.marker
BETA_MARKER := $(MARKER_DIR)/beta.marker

# Collection list - used by the top-level Makefile
# Note: Directory names use underscores, not hyphens
COLLECTIONS := base_system common gamer hardened server_llmchat user_setup vibeops

# Galaxy server URLs
GALAXY_PROD_SERVER := https://galaxy.ansible.com
# Using the correct API endpoint to avoid redirects
GALAXY_BETA_SERVER := https://galaxy-dev.ansible.com/api/v3

# Linting configuration
ANSIBLE_LINT_FLAGS := -p
YAMLLINT_FLAGS := -s
MARKDOWNLINT_FLAGS := 

# Create marker directory if it doesn't exist
$(MARKER_DIR):
	@mkdir -p $(MARKER_DIR)

# Helper function to check if we're on the production branch
check_prod_branch:
	@CURRENT_BRANCH=$$(git rev-parse --abbrev-ref HEAD); \
	if [ "$$CURRENT_BRANCH" != "env/prod" ]; then \
		echo "ERROR: Production deployment can only be done from the 'env/prod' branch."; \
		echo "Current branch: $$CURRENT_BRANCH"; \
		echo "Please checkout the env/prod branch first: git checkout env/prod"; \
		exit 1; \
	fi

# Helper function to check for Galaxy token
check_galaxy_token:
	@if [ -z "$${ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "ERROR: ANSIBLE_GALAXY_TOKEN environment variable is not set."; \
		echo "You can find your token at https://galaxy.ansible.com/ui/token/ after logging in."; \
		echo "Then set it with: export ANSIBLE_GALAXY_TOKEN=your_token"; \
		exit 1; \
	fi
