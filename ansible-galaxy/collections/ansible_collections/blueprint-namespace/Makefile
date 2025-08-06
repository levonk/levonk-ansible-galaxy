# ====================================================================
# Makefile for blueprint-namespace
# This file provides targets for managing blueprint collections
# ====================================================================

# Include common variables
-include ../../../../common.mk

# ====================================================================
# Configuration
# ====================================================================

# Namespace configuration
NAMESPACE_NAME ?= $(notdir $(CURDIR))
NAMESPACE_DIR ?= $(CURDIR)
DIST_DIR ?= $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(CURDIR)))))/../dist
COLLECTIONS ?= $(shell find . -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*" | sed 's|^\./||' | sort)

# ====================================================================
# Phony Targets
# ====================================================================
.PHONY: all help build test lint lint-ansible lint-yaml lint-markdown \
        install install-src install-build install-repo install-beta install-prod \
        clean archive format docs version status

# ====================================================================
# Default Target
# ====================================================================
.DEFAULT_GOAL := help

# Alias for default target
all: build

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mBlueprint Namespace - Available Targets\033[0m"
	@echo "=================================================="
	@echo "\n\033[1mCore Targets:\033[0m"
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z_-]+:.*?## / {if ($$1 !~ /default|help-targets/) printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# ====================================================================
# Build Targets
# ====================================================================

build: ## Build all collections in this namespace
	@echo "\n\033[1mBuilding all collections in namespace $(NAMESPACE_NAME)\033[0m"
	@for collection in $(COLLECTIONS); do \
		if [ -d "$$collection" ]; then \
			echo "\n\033[1;34mBuilding $(NAMESPACE_NAME).$$collection\033[0m"; \
			if [ -f "$$collection/Makefile" ]; then \
				$(MAKE) -C "$$collection" build || echo "\033[1;31mBuild failed for collection $$collection\033[0m"; \
			else \
				(cd "$$collection" && ansible-galaxy collection build --output-path $(DIST_DIR) --force) || \
				echo "\033[1;31mBuild failed for collection $$collection\033[0m"; \
			fi; \
		fi; \
	done
	@echo "\n\033[1;32mBuild complete!\033[0m"

# ====================================================================
# Test Targets
# ====================================================================

test: lint ## Run tests for all collections in this namespace
	@echo "\n\033[1mTesting all collections in namespace $(NAMESPACE_NAME)\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		if [ -d "$$collection" ] && [ -f "$$collection/Makefile" ]; then \
			echo "\n\033[1;34mTesting $(NAMESPACE_NAME).$$collection\033[0m"; \
			if ! $(MAKE) -C "$$collection" test; then \
				echo "\033[1;31mTests failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		fi; \
	done; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED collection(s) failed tests\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll tests passed!\033[0m"; \
	fi

# ====================================================================
# Lint Targets
# ====================================================================

lint: lint-ansible lint-yaml lint-markdown ## Run all linting tools on all collections

lint-ansible: ## Run ansible-lint on all collections
	@echo "\n\033[1mRunning Ansible linter on all collections in $(NAMESPACE_NAME)\033[0m"
	@for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mRunning ansible-lint on $(NAMESPACE_NAME).$$collection\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" lint-ansible; then \
				echo "\033[1;31mAnsible linting failed for collection $$collection\033[0m"; \
				exit 1; \
			fi; \
		else \
			cd "$$collection" && \
			if command -v ansible-lint >/dev/null 2>&1; then \
				ansible-lint $(ANSIBLE_LINT_FLAGS) . || { \
					echo "\033[1;31mAnsible linting failed for collection $$collection\033[0m"; \
					exit 1; \
				}; \
			else \
				echo "\033[1;33mWarning: ansible-lint not installed, skipping\033[0m"; \
			fi; \
		fi; \
	done

lint-yaml: ## Run yamllint on all collections
	@echo "\n\033[1mRunning YAML linter on all collections in $(NAMESPACE_NAME)\033[0m"
	@for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mRunning yamllint on $(NAMESPACE_NAME).$$collection\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" lint-yaml; then \
				echo "\033[1;31mYAML linting failed for collection $$collection\033[0m"; \
				exit 1; \
			fi; \
		else \
			cd "$$collection" && \
			if command -v yamllint >/dev/null 2>&1; then \
				yamllint $(YAMLLINT_FLAGS) . || { \
					echo "\033[1;31mYAML linting failed for collection $$collection\033[0m"; \
					exit 1; \
				}; \
			else \
				echo "\033[1;33mWarning: yamllint not installed, skipping\033[0m"; \
			fi; \
		fi; \
	done

lint-markdown: ## Run markdownlint on all collections
	@echo "\n\033[1mRunning Markdown linter on all collections in $(NAMESPACE_NAME)\033[0m"
	@for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mRunning markdownlint on $(NAMESPACE_NAME).$$collection\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" lint-markdown; then \
				echo "\033[1;31mMarkdown linting failed for collection $$collection\033[0m"; \
				exit 1; \
			fi; \
		else \
			cd "$$collection" && \
			if command -v markdownlint >/dev/null 2>&1; then \
				find . -name "*.md" -exec markdownlint $(MARKDOWNLINT_FLAGS) {} + || { \
					echo "\033[1;31mMarkdown linting failed for collection $$collection\033[0m"; \
					exit 1; \
				}; \
			else \
				echo "\033[1;33mWarning: markdownlint not installed, skipping\033[0m"; \
			fi; \
		fi; \
	done

# ====================================================================
# Installation Targets
# ====================================================================

install: install-src ## Install all collections (alias for install-src)

install-src: ## Install all collections from source
	@echo "\n\033[1mInstalling all collections in namespace $(NAMESPACE_NAME) from source\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mInstalling $(NAMESPACE_NAME).$$collection from source\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" install-src; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			if ! ansible-galaxy collection install "$$collection" --force; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		fi; \
	done; \
	if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n\033[1mRunning namespace test playbook\033[0m"; \
		if ! ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; then \
			echo "\033[1;31mTest playbook failed\033[0m"; \
			FAILED=$$((FAILED + 1)); \
		fi; \
	else \
		echo "\n\033[1;33mNo namespace test playbook found\033[0m"; \
	fi; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED installation(s) failed\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll collections installed successfully!\033[0m"; \
	fi

install-build: build ## Install all collections from build artifacts
	@echo "\n\033[1mInstalling all collections in namespace $(NAMESPACE_NAME) from build artifacts\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mInstalling $(NAMESPACE_NAME).$$collection from build artifact\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" install-build; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			COLLECTION_FILE=$$(find "$(DIST_DIR)" -name "$(NAMESPACE_NAME)-$$collection-*.tar.gz" | sort -V | tail -n 1); \
			if [ -n "$$COLLECTION_FILE" ]; then \
				echo "Installing $$COLLECTION_FILE"; \
				if ! ansible-galaxy collection install "$$COLLECTION_FILE" --force; then \
					echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
					FAILED=$$((FAILED + 1)); \
				fi; \
			else \
				echo "\033[1;31mNo build artifact found for $(NAMESPACE_NAME).$$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		fi; \
	done; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED installation(s) failed\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll collections installed successfully!\033[0m"; \
	fi
	@if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n=== Running namespace test playbook ==="; \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "\nNo namespace test playbook found"; \
	fi

install-repo: ## Install all collections from git repository
	@echo "\n\033[1mInstalling all collections in namespace $(NAMESPACE_NAME) from git repository\033[0m"
	@read -p "Enter branch name (default: main): " branch; \
	branch=$${branch:-main}; \
	echo "\n\033[1mInstalling from branch: $$branch\033[0m"; \
	FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mInstalling $(NAMESPACE_NAME).$$collection from git repository\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" install-repo BRANCH="$$branch"; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			if ! ansible-galaxy collection install "git+https://github.com/levonk/levonk-ansible-galaxy.git#/collections/ansible_collections/$(NAMESPACE_NAME)/$$collection/,$$branch" --force; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		fi; \
	done; \
	if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n\033[1mRunning namespace test playbook\033[0m"; \
		if ! ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; then \
			echo "\033[1;31mTest playbook failed\033[0m"; \
			FAILED=$$((FAILED + 1)); \
		fi; \
	else \
		echo "\n\033[1;33mNo namespace test playbook found\033[0m"; \
	fi; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED installation(s) failed\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll collections installed successfully!\033[0m"; \
	fi

install-beta: ## Install all collections from beta server
	@echo "\n\033[1mInstalling all collections in namespace $(NAMESPACE_NAME) from beta server\033[0m"
	@if [ -z "$(GALAXY_API_KEY)" ]; then \
		echo "\033[1;33mWarning: GALAXY_API_KEY environment variable is not set\033[0m"; \
	fi
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mInstalling $(NAMESPACE_NAME).$$collection from beta server\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" install-beta; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			if ! ansible-galaxy collection install "$(NAMESPACE_NAME).$$collection" --server "https://galaxy-dev.ansible.com" --force; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		fi; \
	done; \
	if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n\033[1mRunning namespace test playbook\033[0m"; \
		if ! ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; then \
			echo "\033[1;31mTest playbook failed\033[0m"; \
			FAILED=$$((FAILED + 1)); \
		fi; \
	else \
		echo "\n\033[1;33mNo namespace test playbook found\033[0m"; \
	fi; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED installation(s) failed\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll collections installed successfully!\033[0m"; \
	fi

install-prod: ## Install all collections from production server
	@echo "\n\033[1mInstalling all collections in namespace $(NAMESPACE_NAME) from production server\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mInstalling $(NAMESPACE_NAME).$$collection from production server\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" install-prod; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			if ! ansible-galaxy collection install "$(NAMESPACE_NAME).$$collection" --force; then \
				echo "\033[1;31mInstallation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		fi; \
	done; \
	if [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		echo "\n\033[1mRunning namespace test playbook\033[0m"; \
		if ! ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; then \
			echo "\033[1;31mTest playbook failed\033[0m"; \
			FAILED=$$((FAILED + 1)); \
		fi; \
	else \
		echo "\n\033[1;33mNo namespace test playbook found\033[0m"; \
	fi; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED installation(s) failed\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll collections installed successfully!\033[0m"; \
	fi

# Alias for install-src
install: install-src ## Install all collections (alias for install-src)

# ====================================================================
# Cleanup Targets
# ====================================================================

clean: clean-collections clean-namespace ## Remove all generated files and build artifacts

clean-collections: ## Clean all collections in the namespace
	@echo "\n\033[1mCleaning all collections in namespace $(NAMESPACE_NAME)\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mCleaning $(NAMESPACE_NAME).$$collection\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" clean; then \
				echo "\033[1;31mClean failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			echo "Removing Python cache files..."; \
			if ! (find "$$collection" -name "*.pyc" -delete && \
			     find "$$collection" -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true); then \
				echo "\033[1;33mWarning: Failed to clean Python cache for $$collection\033[0m"; \
			fi; \
		fi; \
	done; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED collection(s) failed to clean\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll collections cleaned successfully!\033[0m"; \
	fi

clean-namespace: ## Clean namespace build artifacts
	@echo "\n\033[1mCleaning namespace build artifacts\033[0m"
	@if [ -d "$(DIST_DIR)" ]; then \
		echo "Removing build artifacts from $(DIST_DIR)"; \
		rm -rf "$(DIST_DIR)/$(NAMESPACE_NAME)"* 2>/dev/null || true; \
		rm -f "$(DIST_DIR)"/*.log 2>/dev/null || true; \
		echo "\033[1;32mNamespace build artifacts cleaned\033[0m"; \
	else \
		echo "\033[1;33mBuild directory $(DIST_DIR) does not exist, nothing to clean\033[0m"; \
	fi

clean-all: clean ## Alias for clean (for backward compatibility)

# ====================================================================
# Build and Archive Targets
# ====================================================================

archive: build ## Create archives of all collections
	@echo "\n\033[1mArchives created in $(DIST_DIR)\033[0m"
	@if [ -d "$(DIST_DIR)" ]; then \
		FILES=$$(ls -1 "$(DIST_DIR)"/*.tar.gz 2>/dev/null | wc -l); \
		if [ "$$FILES" -gt 0 ]; then \
			echo "\n\033[1;32mFound $$FILES archive(s):\033[0m"; \
			ls -l "$(DIST_DIR)"/*.tar.gz | awk '{print "  " $$9}'; \
		else \
			echo "\n\033[1;33mNo archive files found in $(DIST_DIR)\033[0m"; \
		fi; \
	else \
		echo "\n\033[1;31mError: Build directory $(DIST_DIR) does not exist. Run 'make build' first.\033[0m"; \
		exit 1; \
	fi

# ====================================================================
# Code Formatting and Linting
# ====================================================================

format: ## Format code according to standards in all collections
	@echo "\n\033[1mFormatting all collections in namespace $(NAMESPACE_NAME)\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mFormatting $(NAMESPACE_NAME).$$collection\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" format; then \
				echo "\033[1;31mFormatting failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			echo "Formatting YAML files..."; \
			if ! (find "$$collection" -name "*.yml" -o -name "*.yaml" | xargs -r yamlfmt -w 2>/dev/null || \
			     { echo "\033[1;33myamlfmt not found or failed, trying with yamllint --fix\033[0m"; \
			       yamllint --format colored --strict -f auto -c /dev/null --fix "$$collection" 2>/dev/null || true; }); then \
				echo "\033[1;33mYAML formatting tools not available for $$collection\033[0m"; \
			fi; \
		fi; \
	done; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED collection(s) failed to format\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mAll collections formatted successfully!\033[0m"; \
	fi

# ====================================================================
# Documentation Targets
# ====================================================================

docs: ## Generate documentation for all collections
	@echo "\n\033[1mGenerating documentation for all collections in namespace $(NAMESPACE_NAME)\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34mGenerating documentation for $(NAMESPACE_NAME).$$collection\033[0m"; \
		if [ -f "$$collection/Makefile" ]; then \
			if ! $(MAKE) -C "$$collection" docs; then \
				echo "\033[1;31mDocumentation generation failed for collection $$collection\033[0m"; \
				FAILED=$$((FAILED + 1)); \
			fi; \
		else \
			echo "\033[1;33mNo documentation target found for $$collection\033[0m"; \
		fi; \
	done; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\n\033[1;31m$$FAILED collection(s) failed to generate documentation\033[0m"; \
		exit 1; \
	else \
		echo "\n\033[1;32mDocumentation generated for all collections!\033[0m"; \
	fi

# ====================================================================
# Version and Status Targets
# ====================================================================

version: ## Display versions of all collections
	@echo "\n\033[1mVersions of collections in namespace $(NAMESPACE_NAME):\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		if [ -f "$$collection/galaxy.yml" ]; then \
			VERSION=$$(grep -oP 'version:\s*\K[0-9.]+' "$$collection/galaxy.yml" 2>/dev/null || echo "error"); \
			if [ "$$VERSION" = "error" ]; then \
				echo "\033[1;31m$(NAMESPACE_NAME).$$collection: Failed to read version\033[0m"; \
				FAILED=1; \
			else \
				echo "\033[1;32m$(NAMESPACE_NAME).$$collection: $$VERSION\033[0m"; \
			fi; \
		else \
			echo "\033[1;33m$(NAMESPACE_NAME).$$collection: galaxy.yml not found\033[0m"; \
			FAILED=1; \
		fi; \
	done; \
	exit "$$FAILED"

status: ## Show status of all collections
	@echo "\n\033[1mStatus of collections in namespace $(NAMESPACE_NAME):\033[0m"
	@FAILED=0; \
	for collection in $(COLLECTIONS); do \
		echo "\n\033[1;34m=== Collection: $(NAMESPACE_NAME).$$collection ===\033[0m"; \
		\
		# Check version
		if [ -f "$$collection/galaxy.yml" ]; then \
			VERSION=$$(grep -oP 'version:\s*\K[0-9.]+' "$$collection/galaxy.yml" 2>/dev/null || echo "error"); \
			if [ "$$VERSION" = "error" ]; then \
				echo "  Version: \033[1;31mFailed to read\033[0m"; \
				FAILED=1; \
			else \
				echo "  Version: \033[1;32m$$VERSION\033[0m"; \
			fi; \
		else \
			echo "  Version: \033[1;33mgalaxy.yml not found\033[0m"; \
			FAILED=1; \
		fi; \
		\
		# Check build status
		echo "  Location: \033[1;36m$(NAMESPACE_DIR)/$$collection\033[0m"; \
		if [ -d "$(DIST_DIR)" ]; then \
			BUILD_FILE=$$(find "$(DIST_DIR)" -name "$(NAMESPACE_NAME)-$$collection-*.tar.gz" | sort -V | tail -n 1); \
			if [ -n "$$BUILD_FILE" ]; then \
				BUILD_VERSION=$$(basename "$$BUILD_FILE" | grep -oP '$(NAMESPACE_NAME)-[^-]+-\K[0-9.]+(?=\.tar\.gz)'); \
				if [ -n "$$VERSION" ] && [ "$$VERSION" = "$$BUILD_VERSION" ]; then \
					echo "  Build:    \033[1;32mAvailable ($$BUILD_VERSION)\033[0m"; \
				else \
					echo "  Build:    \033[1;33mAvailable ($$BUILD_VERSION) - Version mismatch\033[0m"; \
					FAILED=1; \
				fi; \
			else \
				echo "  Build:    \033[1;31mNot built\033[0m"; \
				FAILED=1; \
			fi; \
		else \
			echo "  Build:    \033[1;33mNo build directory\033[0m"; \
		fi; \
		\
		# Check test status if Makefile exists
		if [ -f "$$collection/Makefile" ]; then \
			if $(MAKE) -C "$$collection" test >/dev/null 2>&1; then \
				echo "  Tests:    \033[1;32mPassing\033[0m"; \
			else \
				echo "  Tests:    \033[1;31mFailing\033[0m"; \
				FAILED=1; \
			fi; \
		else \
			echo "  Tests:    \033[1;33mNo test target\033[0m"; \
		fi; \
	done; \
	echo ""; \
	if [ "$$FAILED" -ne 0 ]; then \
		echo "\033[1;31mSome issues were found. Check the status above.\033[0m"; \
		exit 1; \
	else \
		echo "\033[1;32mAll collections are in good shape!\033[0m"; \
	fi

# Help target
help: ## Show this help message
	@echo "Ansible Namespace: $(NAMESPACE_NAME)"
	@echo "Collections: $(COLLECTIONS)"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Alias for help
usage: help ## Show help message (alias for help)
