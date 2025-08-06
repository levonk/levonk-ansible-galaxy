# ====================================================================
# Makefile for tests in {{ role_name }}
#
# This Makefile provides targets for managing role tests.
# ====================================================================

# Include common variables
-include ../../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Test files
TESTS := $(wildcard test_*.yml)
TEST_NAMES = $(basename $(TESTS))

# Phony targets
.PHONY: all test lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run tests
test: ## Run all tests
	@echo "${GREEN}Running tests...${NC}"
	@if [ -f "test.yml" ]; then \
		ansible-playbook test.yml; \
	else \
		echo "${YELLOW}No test.yml found, skipping${NC}"; \
	fi

# Lint test files
lint: ## Lint test files
	@echo "${GREEN}Linting test files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint .; \
	else \
		echo "${YELLOW}yamllint not found, skipping${NC}"; \
	fi

# Format test files
format: ## Format test files
	@echo "${GREEN}Formatting test files...${NC}"
	@if command -v yamllint >/dev/null; then \
		yamllint --format=auto --fix . || true; \
	fi

# Clean test artifacts
clean: ## Clean test artifacts
	@echo "${YELLOW}Cleaning test artifacts...${NC}"
	@find . -type f -name "*.retry" -delete

# List available test files
list: ## List available test files
	@echo "${GREEN}Available test files:${NC}"
	@for test in $(TESTS); do \
		echo "- $$test"; \
	done

# Individual test targets
$(TEST_NAMES): %: %.yml
	@echo "${GREEN}Running test: $<${NC}"
	ansible-playbook $<

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ role_name }} - Tests Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
