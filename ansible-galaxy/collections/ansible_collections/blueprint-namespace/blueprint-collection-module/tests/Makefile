# ====================================================================
# Makefile for Tests in {{ collection_name }}
#
# This Makefile provides targets for managing tests in the collection.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Directories
TESTS_DIR := .
INTEGRATION_DIR := integration
UNIT_DIR := unit

# Find all test files
TEST_FILES := $(wildcard $(TESTS_DIR)/test_*.py)
INTEGRATION_TESTS := $(wildcard $(INTEGRATION_DIR)/test_*.py)
UNIT_TESTS := $(wildcard $(UNIT_DIR)/test_*.py)

# Python interpreter
PYTHON ?= python3
PYTEST_OPTS ?= -v

# Phony targets
.PHONY: all test integration unit lint format clean help

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run all tests
test: unit integration ## Run all tests

# Run integration tests
integration: ## Run integration tests
	@if [ -n "$(INTEGRATION_TESTS)" ]; then \
		echo "${GREEN}Running integration tests...${NC}"; \
		$(PYTHON) -m pytest $(PYTEST_OPTS) $(INTEGRATION_DIR); \
	else \
		echo "${YELLOW}No integration tests found${NC}"; \
	fi

# Run unit tests
unit: ## Run unit tests
	@if [ -n "$(UNIT_TESTS)" ]; then \
		echo "${GREEN}Running unit tests...${NC}"; \
		$(PYTHON) -m pytest $(PYTEST_OPTS) $(UNIT_DIR); \
	else \
		echo "${YELLOW}No unit tests found${NC}"; \
	fi

# Lint test files
lint: ## Lint test files
	@echo "${GREEN}Linting test files...${NC}"
	@if command -v pylint >/dev/null; then \
		echo "${YELLOW}Running pylint...${NC}"; \
		pylint --disable=C0114,C0115,C0116 $(TEST_FILES) $(INTEGRATION_TESTS) $(UNIT_TESTS) || true; \
	else \
		echo "${YELLOW}pylint not found, skipping Python linting${NC}"; \
	fi
	@if command -v yamllint >/dev/null; then \
		echo "${YELLOW}Running yamllint...${NC}"; \
		yamllint . || true; \
	else \
		echo "${YELLOW}yamllint not found, skipping YAML linting${NC}"; \
	fi

# Format test files
format: ## Format test files
	@echo "${GREEN}Formatting test files...${NC}"
	@if command -v black >/dev/null; then \
		echo "${YELLOW}Running black...${NC}"; \
		black $(TEST_FILES) $(INTEGRATION_TESTS) $(UNIT_TESTS); \
	else \
		echo "${YELLOW}black not found, skipping code formatting${NC}"; \
	fi
	@if command -v isort >/dev/null; then \
		echo "${YELLOW}Running isort...${NC}"; \
		isort $(TEST_FILES) $(INTEGRATION_TESTS) $(UNIT_TESTS); \
	else \
		echo "${YELLOW}isort not found, skipping import sorting${NC}"; \
	fi

# Clean test artifacts
clean: ## Clean test artifacts
	@echo "${YELLOW}Cleaning test artifacts...${NC}"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name ".pytest_cache" -exec rm -rf {} +
	@find . -type d -name ".mypy_cache" -exec rm -rf {} +
	@rm -f .coverage coverage.xml htmlcov/

# Generate coverage report
coverage: ## Generate test coverage report
	@echo "${GREEN}Generating coverage report...${NC}"
	@if command -v pytest-cov >/dev/null; then \
		$(PYTHON) -m pytest --cov=ansible_collections.$(shell echo "{{ collection_name }}" | tr '-' '.') \
			--cov-report=term --cov-report=xml --cov-report=html $(PYTEST_OPTS); \
	else \
		echo "${YELLOW}pytest-cov not found, please install with: pip install pytest-cov${NC}"; \
	fi

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ collection_name }} - Test Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
