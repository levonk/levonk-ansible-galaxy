# ====================================================================
# common.mk - Shared Variables and Settings
# This file provides common variables and settings used across all Makefiles.
# It is included by other Makefiles and should not be executed directly.
# ====================================================================

# Prevent multiple inclusions
ifndef COMMON_MK_INCLUDED
COMMON_MK_INCLUDED := true

# ====================================================================
# Directory Structure
# ====================================================================

# Base directories (can be overridden by including Makefile)
ROOT_DIR ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/..
BIN_DIR ?= $(ROOT_DIR)/bin
DIST_DIR ?= $(ROOT_DIR)/dist
COLLECTIONS_DIR ?= $(ROOT_DIR)/ansible-galaxy/collections
DOCS_DIR ?= $(ROOT_DIR)/docs
BUILD_DIR ?= $(ROOT_DIR)/build

# Project Configuration
NAMESPACE ?= levonk
PROJECT_NAME ?= $(notdir $(shell pwd))
VERSION ?= $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")

# ====================================================================
# Collection Configuration
# ====================================================================

# Default collection list (can be overridden)
# Note: Directory names use underscores to match Ansible collection naming
COLLECTIONS ?= base_system common gamer hardened server_llmchat user_setup vibeops

# ====================================================================
# Build System Configuration
# ====================================================================

# Marker files for build tracking
MARKER_DIR ?= $(ROOT_DIR)/.markers
CLEAN_MARKER ?= $(MARKER_DIR)/clean.marker
LINT_MARKER ?= $(MARKER_DIR)/lint.marker
BUILD_MARKER ?= $(MARKER_DIR)/build.marker
TEST_MARKER ?= $(MARKER_DIR)/test.marker
BETA_MARKER ?= $(MARKER_DIR)/beta.marker

# ====================================================================
# Ansible Galaxy Configuration
# ====================================================================

# Galaxy server endpoints
GALAXY_PROD_SERVER ?= https://galaxy.ansible.com
GALAXY_BETA_SERVER ?= https://galaxy-dev.ansible.com/api/v3
GALAXY_API_VERSION ?= v3

# ====================================================================
# Tool Configuration
# ====================================================================

# Command overrides (allow for containerized or custom installations)
ANSIBLE_GALAXY ?= ansible-galaxy
ANSIBLE_LINT ?= ansible-lint
PYTHON ?= python3
PIP ?= pip3

# Tool flags and options
ANSIBLE_LINT_FLAGS ?= -p
YAMLLINT_FLAGS ?= -s
MARKDOWNLINT_FLAGS ?=

# ====================================================================
# Collection Paths
# ====================================================================

# Collection directory structure
COLLECTION_NAMESPACE_DIR ?= $(COLLECTIONS_DIR)/ansible_collections/$(NAMESPACE)
COLLECTION_DIR ?= $(COLLECTION_NAMESPACE_DIR)/$(COLLECTION)
COLLECTION_DIST ?= $(DIST_DIR)/$(NAMESPACE)-$(COLLECTION)-*.tar.gz
COLLECTION_GALAXY_YML ?= $(COLLECTION_DIR)/galaxy.yml

# ====================================================================
# Version Information
# ====================================================================

# Version detection
# Uses print-version.sh if available, otherwise falls back to 0.1.0
VERSION ?= $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")

# ====================================================================
# Directory Creation
# ====================================================================

# Create required directories if they don't exist
$(MARKER_DIR) $(DIST_DIR) $(BUILD_DIR) $(DOCS_DIR):
	@mkdir -p $@

# ====================================================================
# Helper Functions
# ====================================================================

# Check if current branch is the production branch
# Usage: $(call check_prod_branch)
define check_prod_branch
	@CURRENT_BRANCH=$$(git rev-parse --abbrev-ref HEAD); \
	if [ "$$CURRENT_BRANCH" != "env/prod" ]; then \
		echo "\033[1;31mERROR: Production deployment can only be done from the 'env/prod' branch.\033[0m"; \
		echo "  Current branch: $$CURRENT_BRANCH"; \
		echo "  Please checkout the env/prod branch first: git checkout env/prod"; \
		exit 1; \
	fi
endef

# Check if Galaxy authentication token is set
# Usage: $(call check_galaxy_token)
define check_galaxy_token
	@if [ -z "$${ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "\033[1;31mERROR: ANSIBLE_GALAXY_TOKEN environment variable is not set.\033[0m"; \
		echo "  You can find your token at https://galaxy.ansible.com/ui/token/ after logging in."; \
		echo "  Then set it with: export ANSIBLE_GALAXY_TOKEN=your_token"; \
		exit 1; \
	fi
endef

# ====================================================================
# End of common.mk
# ====================================================================

endif # COMMON_MK_INCLUDED
