# Role-level Makefile for blueprint-role
# Handles linting and molecule testing for this role

.PHONY: all test lint molecule build install install-src install-build install-repo install-beta install-prod

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

# Default target
all: test

# Build this role as part of its collection
build:
	@echo "Building collection $(NAMESPACE_NAME).$(COLLECTION_NAME) containing role $(ROLE_NAME)..."
	@cd $(COLLECTION_DIR) && ansible-galaxy collection build --output-path $(DIST_DIR) --force
	@echo "Build complete. Collection archive in $(DIST_DIR)"

# Install targets

# Install from source directory
install-src:
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
install-build: build
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
install-repo:
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
install-beta:
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
install-prod:
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
install: install-src

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
