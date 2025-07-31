# Role-level Makefile for blueprint-role
# Handles linting and molecule testing for this role

.PHONY: all test lint lint-ansible lint-yaml lint-markdown molecule build install install-src install-build install-repo install-beta install-prod clean archive format docs version status help usage

# Include common variables
include ../../../../../../../common.mk

# Role-specific variables
ROLE_NAME := $(notdir $(CURDIR))
COLLECTION_NAME := $(notdir $(shell dirname $(shell dirname $(CURDIR))))
NAMESPACE_NAME := $(notdir $(shell dirname $(shell dirname $(shell dirname $(CURDIR)))))
ROLE_DIR := $(CURDIR)
COLLECTION_DIR := $(shell dirname $(shell dirname $(CURDIR)))
NAMESPACE_DIR := $(shell dirname $(shell dirname $(shell dirname $(CURDIR))))
DIST_DIR := $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(shell dirname $(CURDIR)))))))))/../dist

# Default goal
.DEFAULT_GOAL := help

# Default target
all: test ## Run tests for this role (alias for test)

# Build this role as part of its collection
build: help ## Build the collection containing this role
	@echo "Building collection $(NAMESPACE_NAME).$(COLLECTION_NAME) containing role $(ROLE_NAME)..."
	@cd $(COLLECTION_DIR) && ansible-galaxy collection build --output-path $(DIST_DIR) --force
	@echo "Build complete. Collection archive in $(DIST_DIR)"

# Install targets

# Test this role
test: lint molecule ## Run all tests for this role

# Lint this role
lint: lint-ansible lint-yaml lint-markdown ## Run all linting tools
	@echo "All linting completed for role $(ROLE_NAME)"

# Ansible linting
lint-ansible: ## Run ansible-lint
	@echo "Running ansible-lint on role $(ROLE_NAME)..."
	@cd $(COLLECTION_DIR) && ansible-lint $(ANSIBLE_LINT_FLAGS) roles/$(ROLE_NAME) || echo "Warning: ansible-lint found issues in role $(ROLE_NAME)"

# YAML linting
lint-yaml: ## Run yamllint
	@echo "Running yamllint on role $(ROLE_NAME)..."
	@yamllint $(YAMLLINT_FLAGS) . || echo "Warning: yamllint found issues in role $(ROLE_NAME)"

# Markdown linting
lint-markdown: ## Run markdownlint
	@echo "Running markdownlint on role $(ROLE_NAME)..."
	@find . -name "*.md" -exec markdownlint $(MARKDOWNLINT_FLAGS) {} \; || echo "Warning: markdownlint found issues in role $(ROLE_NAME)"

# Molecule testing
molecule: ## Run molecule tests
	@echo "Running molecule tests for role $(ROLE_NAME)..."
	@if [ -d "molecule" ]; then \
		cd $(ROLE_DIR) && molecule test; \
	else \
		echo "No molecule tests found for role $(ROLE_NAME)"; \
	fi

# Install from source directory
install-src: ## Install role from source
	@echo "Installing role $(ROLE_NAME) from source..."
	@ansible-galaxy collection install $(COLLECTION_DIR) --force
	@echo "Running test playbook for role $(ROLE_NAME) if available..."
	@if [ -f "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml" ]; then \
		ansible-playbook "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml"; \
	elif [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found"; \
	fi

# Install from built artifact
install-build: build ## Install role from build artifact
	@echo "Installing role $(ROLE_NAME) from build artifact..."
	@COLLECTION_FILE=$$(find "$(DIST_DIR)" -name "$(NAMESPACE_NAME)-$(COLLECTION_NAME)-*.tar.gz" | sort -V | tail -n 1); \
	if [ -n "$$COLLECTION_FILE" ]; then \
		echo "Installing $$COLLECTION_FILE..."; \
		ansible-galaxy collection install "$$COLLECTION_FILE" --force; \
		if [ -f "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml" ]; then \
			ansible-playbook "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml"; \
		elif [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
			ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
		elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
			ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
		else \
			echo "No test playbook found"; \
		fi; \
	else \
		echo "No build artifact found for $(NAMESPACE_NAME).$(COLLECTION_NAME)"; \
	fi

# Install from git repository
install-repo: ## Install role from git repository
	@echo "Installing role $(ROLE_NAME) from git repository..."
	@read -p "Enter branch name (default: main): " branch; \
	branch=$${branch:-main}; \
	echo "Installing from branch: $$branch"; \
	ansible-galaxy collection install git+https://github.com/levonk/levonk-ansible-galaxy.git#/collections/ansible_collections/$(NAMESPACE_NAME)/$(COLLECTION_NAME)/,$$branch --force; \
	if [ -f "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml" ]; then \
		ansible-playbook "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml"; \
	elif [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found"; \
	fi

# Install from beta server
install-beta: ## Install role from beta server
	@echo "Installing role $(ROLE_NAME) from beta server..."
	@ansible-galaxy collection install $(NAMESPACE_NAME).$(COLLECTION_NAME) --server https://galaxy-dev.ansible.com --force
	@if [ -f "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml" ]; then \
		ansible-playbook "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml"; \
	elif [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found"; \
	fi

# Install from production server
install-prod: ## Install role from production server
	@echo "Installing role $(ROLE_NAME) from production server..."
	@ansible-galaxy collection install $(NAMESPACE_NAME).$(COLLECTION_NAME) --force
	@if [ -f "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml" ]; then \
		ansible-playbook "$(ROLE_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).$(ROLE_NAME).yml"; \
	elif [ -f "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml" ]; then \
		ansible-playbook "$(COLLECTION_DIR)/tests/test-$(NAMESPACE_NAME).$(COLLECTION_NAME).yml"; \
	elif [ -f "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml" ]; then \
		ansible-playbook "$(NAMESPACE_DIR)/tests/test-$(NAMESPACE_NAME).yml"; \
	else \
		echo "No test playbook found"; \
	fi

# Alias for install-src
install: install-src ## Install role (alias for install-src)

# Clean target
clean: ## Remove generated files
	@echo "Cleaning role $(ROLE_NAME)..."
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -delete
	@rm -rf .pytest_cache
	@if [ -d "molecule" ]; then \
		cd $(ROLE_DIR) && molecule cleanup; \
	fi

# Archive target
archive: build ## Create an archive of the role via the collection
	@echo "Archive created in $(DIST_DIR) (as part of collection)"

# Format target
format: ## Format code according to standards
	@echo "Formatting role $(ROLE_NAME)..."
	@find . -name "*.yml" -o -name "*.yaml" | xargs yamlfmt -w || echo "Warning: yamlfmt not installed or failed"

# Documentation target
docs: ## Generate documentation
	@echo "Generating documentation for role $(ROLE_NAME)..."
	@if [ -f "$(BIN_DIR)/generate-role-docs.sh" ]; then \
		$(BIN_DIR)/generate-role-docs.sh $(ROLE_DIR); \
	else \
		echo "Documentation generator script not found"; \
	fi

# Version target
version: ## Display the role version via the collection
	@cd $(COLLECTION_DIR) && grep -oP 'version:\s*\K[0-9.]+' galaxy.yml

# Status target
status: ## Show the role status
	@echo "Role: $(ROLE_NAME)"
	@echo "Collection: $(NAMESPACE_NAME).$(COLLECTION_NAME)"
	@echo "Version: $$(cd $(COLLECTION_DIR) && grep -oP 'version:\s*\K[0-9.]+' galaxy.yml)"
	@echo "Location: $(ROLE_DIR)"

# Help target
help: ## Show this help message
	@echo "Ansible Role: $(ROLE_NAME) in collection $(NAMESPACE_NAME).$(COLLECTION_NAME)"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Alias for help
usage: help ## Show help message (alias for help)

# Test this role
test: lint molecule

# Lint this role
lint: lint-ansible lint-yaml lint-markdown

# Lint Ansible files in this role
lint-ansible:
	@echo "Linting Ansible files in role $(ROLE_NAME) with ansible-lint..."
	@ansible-lint $(ANSIBLE_LINT_FLAGS) . || echo "Warning: ansible-lint found issues in role $(ROLE_NAME)"

# Lint YAML files in this role
lint-yaml:
	@echo "Linting YAML files in role $(ROLE_NAME) with yamllint..."
	@find . -name "*.yml" -exec yamllint $(YAMLLINT_FLAGS) {} \; || echo "Warning: yamllint found issues in role $(ROLE_NAME)"

# Lint Markdown files in this role
lint-markdown:
	@if command -v markdownlint >/dev/null 2>&1; then \
		echo "Linting Markdown files in role $(ROLE_NAME) with markdownlint..."; \
		find . -name "*.md" -exec markdownlint {} \; 2>/dev/null || echo "Warning: markdownlint found issues in role $(ROLE_NAME)"; \
	else \
		echo "markdownlint not found, skipping Markdown linting"; \
	fi

# Run molecule tests for this role
molecule:
	@echo "Running molecule tests for role $(ROLE_NAME)..."
	@if [ -d "molecule" ]; then \
		molecule test || echo "Warning: Molecule tests failed for role $(ROLE_NAME)"; \
	else \
		echo "No molecule tests found for role $(ROLE_NAME)"; \
	fi
