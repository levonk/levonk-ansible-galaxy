'use strict';

/**
 * Makefile-Nx Bridge
 * 
 * This script provides a bridge between the Makefile targets and Nx commands.
 * It allows users to continue using the familiar `make` commands while
 * leveraging the Nx build system under the hood.
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const ROOT_DIR = path.resolve(__dirname, '../..');
const MAKEFILE_PATH = path.join(ROOT_DIR, 'Makefile.nx');
const COLLECTIONS_DIR = path.join(ROOT_DIR, 'ansible-galaxy/collections/ansible_collections/levonk');

// Color codes for console output
const colors = {
  reset: '\x1b[0m',
  cyan: '\x1b[36m',
  green: '\x1b[32m'
};

/**
 * Get all collection directories
 * @returns {Array<string>} - Collection names
 */
function getCollections() {
  try {
    return fs.readdirSync(COLLECTIONS_DIR)
      .filter(file => fs.statSync(path.join(COLLECTIONS_DIR, file)).isDirectory());
  } catch (error) {
    console.error(`Error reading collections directory: ${error.message}`);
    return [];
  }
}

/**
 * Get all roles for a collection
 * @param {string} collection - Collection name
 * @returns {Array<string>} - Role names
 */
function getRoles(collection) {
  const rolesDir = path.join(COLLECTIONS_DIR, collection, 'roles');
  try {
    if (fs.existsSync(rolesDir)) {
      return fs.readdirSync(rolesDir)
        .filter(file => fs.statSync(path.join(rolesDir, file)).isDirectory());
    }
    return [];
  } catch (error) {
    console.error(`Error reading roles for collection ${collection}: ${error.message}`);
    return [];
  }
}

/**
 * Generate Makefile content
 * @returns {string} - Makefile content
 */
function generateMakefile() {
  const collections = getCollections();
  
  let content = `# ====================================================================
# Nx-powered Makefile for levonk-ansible-galaxy
# This file provides Makefile targets that use the Nx build system
# ====================================================================

# Include common variables
-include ansible-galaxy/common.mk

# ====================================================================
# Project Configuration
# ====================================================================
PROJECT_NAME ?= levonk-ansible-galaxy
BIN_DIR ?= $(shell pwd)/bin
VERSION ?= $(shell $(BIN_DIR)/print-version.sh 2>/dev/null || echo "0.1.0")
DIST_DIR ?= $(shell pwd)/dist
ANSIBLE_GALAXY_DIR ?= ansible-galaxy

# Standard directories
DOCS_DIR ?= docs
TESTS_DIR ?= tests
BUILD_DIR ?= build

# Tool commands
PYTHON ?= python3
PIP ?= pip3
NPX ?= npx

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help list list-collections dev-beta debug-beta FORCE \\
        clean format lint test build install uninstall \\
        publish-beta publish-prod install-beta install-prod install-src \\
        check-env check-tools docs version status \\
        check check-ansible check-yaml check-markdown \\
        setup setup-dev setup-test setup-docs \\
        pre-commit pre-commit-install pre-commit-run pre-commit-clean \\
        nx-setup nx-verify

# ====================================================================
# Default Target
# ====================================================================
.DEFAULT_GOAL := help

# Alias for default target
all: help

# ====================================================================
# Help and Documentation
# ====================================================================

help: ## Show this help message
\t@echo "$(PROJECT_NAME) $(VERSION)"
\t@echo ""
\t@echo "Usage: make [target]"
\t@echo ""
\t@echo "Targets:"
\t@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST)
\t@echo ""
\t@echo "For more detailed help, run: npm run help"

# ====================================================================
# Nx Setup and Verification
# ====================================================================

nx-setup: ## Set up the Nx build system
\tnpm run setup

nx-verify: ## Verify the Nx build system setup
\tnpm run verify

# ====================================================================
# Core Targets
# ====================================================================

clean: ## Clean build artifacts
\t$(NPX) nx run levonk-ansible-galaxy-workspace:clean

check-env: ## Check environment variables
\t$(NPX) nx run levonk-ansible-galaxy-workspace:check-env

check-tools: ## Check required tools
\t$(NPX) nx run levonk-ansible-galaxy-workspace:check-tools

docs: ## Generate documentation
\t$(NPX) nx run levonk-ansible-galaxy-workspace:docs

version: ## Show version information
\t$(NPX) nx run levonk-ansible-galaxy-workspace:version

status: ## Show project status
\t$(NPX) nx run levonk-ansible-galaxy-workspace:status

# ====================================================================
# Linting Targets
# ====================================================================

lint: ## Run all linters
\t$(NPX) nx run-many --target=lint --all

check: lint ## Alias for lint

check-ansible: ## Lint Ansible files
\t$(NPX) nx run levonk-ansible-galaxy-workspace:lint-ansible

check-yaml: ## Lint YAML files
\t$(NPX) nx run levonk-ansible-galaxy-workspace:lint-yaml

check-markdown: ## Lint Markdown files
\t$(NPX) nx run levonk-ansible-galaxy-workspace:lint-markdown

# ====================================================================
# Testing Targets
# ====================================================================

test: ## Run all tests
\t$(NPX) nx run-many --target=test --all

# ====================================================================
# Build Targets
# ====================================================================

build: ## Build all collections
\t$(NPX) nx run-many --target=build --all

# ====================================================================
# Installation Targets
# ====================================================================

install: install-src ## Install from source (default)

install-src: ## Install from source
\t$(NPX) nx run-many --target=inst-src --all

install-beta: ## Install from beta server
\t$(NPX) nx run-many --target=inst-beta --all

install-prod: ## Install from production server
\t$(NPX) nx run-many --target=inst-prod --all

uninstall: ## Uninstall collections
\t$(NPX) nx run-many --target=uninstall --all

# ====================================================================
# Publishing Targets
# ====================================================================

publish-beta: ## Publish to beta server
\t$(NPX) nx run-many --target=publish-beta --all

publish-prod: ## Publish to production server
\t$(NPX) nx run-many --target=publish-prod --all

# ====================================================================
# Collection-specific Targets
# ====================================================================
`;

  // Generate collection-specific targets
  collections.forEach(collection => {
    content += `
# ---- Collection: ${collection} ----
build-${collection}: ## Build ${collection} collection
\t$(NPX) nx build ${collection}

test-${collection}: ## Test ${collection} collection
\t$(NPX) nx test ${collection}

lint-${collection}: ## Lint ${collection} collection
\t$(NPX) nx lint ${collection}

publish-beta-${collection}: ## Publish ${collection} to beta server
\t$(NPX) nx run ${collection}:publish-beta

publish-prod-${collection}: ## Publish ${collection} to production server
\t$(NPX) nx run ${collection}:publish-prod

install-src-${collection}: ## Install ${collection} from source
\t$(NPX) nx run ${collection}:inst-src

install-beta-${collection}: ## Install ${collection} from beta server
\t$(NPX) nx run ${collection}:inst-beta

install-prod-${collection}: ## Install ${collection} from production server
\t$(NPX) nx run ${collection}:inst-prod

uninstall-${collection}: ## Uninstall ${collection}
\t$(NPX) nx run ${collection}:uninstall
`;

    // Generate role-specific targets
    const roles = getRoles(collection);
    roles.forEach(role => {
      content += `
# ---- Role: ${collection}.${role} ----
test-${collection}-${role}: ## Test ${collection}.${role} role
\t$(NPX) nx test ${collection}-${role}

lint-${collection}-${role}: ## Lint ${collection}.${role} role
\t$(NPX) nx lint ${collection}-${role}

molecule-${collection}-${role}: ## Run molecule tests for ${collection}.${role} role
\t$(NPX) nx run ${collection}-${role}:molecule
`;
    });
  });

  // Add setup targets
  content += `
# ====================================================================
# Setup Targets
# ====================================================================

setup: nx-setup ## Set up the project

setup-dev: setup ## Set up development environment
\t$(BIN_DIR)/setup-dev.sh

setup-test: ## Set up test environment
\t$(BIN_DIR)/setup-test.sh

setup-docs: ## Set up documentation environment
\t$(BIN_DIR)/setup-docs.sh

# ====================================================================
# Pre-commit Targets
# ====================================================================

pre-commit: pre-commit-run ## Run pre-commit hooks

pre-commit-install: ## Install pre-commit hooks
\t$(BIN_DIR)/pre-commit-install.sh

pre-commit-run: ## Run pre-commit hooks
\t$(BIN_DIR)/pre-commit-run.sh

pre-commit-clean: ## Clean pre-commit cache
\t$(BIN_DIR)/pre-commit-clean.sh
`;

  return content;
}

/**
 * Main function
 */
function main() {
  console.log(`${colors.cyan}Generating Nx-powered Makefile...${colors.reset}`);
  
  // Generate Makefile content
  const makefileContent = generateMakefile();
  
  // Write to file
  fs.writeFileSync(MAKEFILE_PATH, makefileContent);
  
  console.log(`${colors.green}Generated Makefile.nx successfully!${colors.reset}`);
  console.log(`You can use it with: make -f Makefile.nx [target]`);
  console.log(`To replace the existing Makefile: mv Makefile.nx Makefile`);
}

// Run the main function
main();
