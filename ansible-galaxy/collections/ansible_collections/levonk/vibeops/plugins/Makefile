# ====================================================================
# Makefile for plugins in levonk.vibeops
#
# This Makefile provides targets for managing plugins within the
# vibeops collection, including testing, linting, and documentation.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Plugin directories
PLUGIN_TYPES := $(notdir $(wildcard *))

# Phony targets
.PHONY: all test lint format clean help $(PLUGIN_TYPES)

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Run tests for all plugin types
test: $(PLUGIN_TYPES) ## Run tests for all plugin types

# Lint all plugins
lint: ## Lint all plugins
	@echo "${GREEN}Running linters on all plugins...${NC}"
	@for type in $(PLUGIN_TYPES); do \
		if [ -d "$$type" ] && [ -f "$$type/Makefile" ]; then \
			echo "\n${GREEN}Linting plugin type: $$type${NC}"; \
			$(MAKE) -C "$$type" lint || exit 1; \
		elif [ -d "$$type" ]; then \
			echo "\n${YELLOW}No Makefile found for plugin type: $$type, using default linting${NC}"; \
			ansible-lint "$$type" || exit 1; \
		fi; \
	done

# Format code in all plugins
format: ## Format code in all plugins
	@echo "${GREEN}Formatting code in all plugins...${NC}"
	@for type in $(PLUGIN_TYPES); do \
		if [ -d "$$type" ] && [ -f "$$type/Makefile" ]; then \
			echo "\n${GREEN}Formatting plugin type: $$type${NC}"; \
			$(MAKE) -C "$$type" format || true; \
		elif [ -d "$$type" ]; then \
			echo "\n${YELLOW}No Makefile found for plugin type: $$type, using default formatting${NC}"; \
			find "$$type" -name '*.py' -o -name '*.yml' -o -name '*.yaml' | xargs yamllint --format=auto --fix || true; \
		fi; \
	done

# Clean build artifacts
clean: ## Clean build artifacts for all plugins
	@echo "${YELLOW}Cleaning build artifacts for all plugins...${NC}"
	@for type in $(PLUGIN_TYPES); do \
		if [ -d "$$type" ] && [ -f "$$type/Makefile" ]; then \
			echo "\n${YELLOW}Cleaning plugin type: $$type${NC}"; \
			$(MAKE) -C "$$type" clean || true; \
		fi; \
		rm -rf "$$type/__pycache__" "$$type/*.pyc" "$$type/*.pyo" "$$type/*.pyd" "$$type/.pytest_cache"; \
	done

# List all plugin types
list: ## List all available plugin types
	@echo "${GREEN}Available plugin types in vibeops collection:${NC}"
	@echo "======================================"
	@for type in $(PLUGIN_TYPES); do \
		if [ -d "$$type" ]; then \
			echo "- $$type"; \
		fi; \
	done

# Individual plugin type targets
$(PLUGIN_TYPES):
	@if [ -d "$@" ] && [ -f "$@/Makefile" ]; then \
		echo "\n${GREEN}Processing plugin type: $@${NC}"; \
		$(MAKE) -C "$@" || exit 1; \
	elif [ -d "$@" ]; then \
		echo "\n${YELLOW}No Makefile found for plugin type: $@${NC}"; \
	fi

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1mlevonk.vibeops - Plugins Management\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-15s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# Set default target
.DEFAULT_GOAL := help
