# ====================================================================
# Makefile for documentation in {{ namespace_name }}.{{ collection_name }}
#
# This Makefile provides targets for building, testing, and managing
# documentation for the collection.
# ====================================================================

# Include common variables
-include ../../../../../common.mk

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Documentation source and build directories
DOCS_SRC_DIR := .
DOCS_BUILD_DIR := _build

# Documentation formats
DOC_FORMATS := html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext

# Phony targets
.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext test

# ====================================================================
# Main Targets
# ====================================================================

# Default target
all: help

# Build HTML documentation
html: ## Generate HTML documentation
	@echo "${GREEN}Building HTML documentation...${NC}"
	@if command -v sphinx-build >/dev/null; then \
		sphinx-build -b html "$(DOCS_SRC_DIR)" "$(DOCS_BUILD_DIR)/html" $(SPHINXOPTS) $(O); \
		echo "${GREEN}HTML documentation built in $(DOCS_BUILD_DIR)/html${NC}"; \
	else \
		echo "${YELLOW}sphinx-build not found, skipping documentation build${NC}"; \
	fi

# Clean documentation build artifacts
clean: ## Clean documentation build artifacts
	@echo "${YELLOW}Cleaning documentation build artifacts...${NC}"
	@rm -rf "$(DOCS_BUILD_DIR)"
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.py[co]" -delete
	@echo "${GREEN}Clean complete.${NC}"

# Test documentation
test: ## Test documentation build
	@echo "${GREEN}Testing documentation build...${NC}"
	@if command -v sphinx-build >/dev/null; then \
		sphinx-build -b doctest "$(DOCS_SRC_DIR)" "$(DOCS_BUILD_DIR)/doctest" $(SPHINXOPTS) $(O); \
	else \
		echo "${YELLOW}sphinx-build not found, skipping documentation tests${NC}"; \
	fi

# Install documentation dependencies
install-deps: ## Install documentation dependencies
	@echo "${GREEN}Installing documentation dependencies...${NC}"
	@if [ -f "requirements.txt" ]; then \
		pip install -r requirements.txt; \
	else \
		echo "${YELLOW}No requirements.txt found, skipping dependency installation${NC}"; \
	fi

# Serve documentation locally
serve: html ## Build and serve documentation locally
	@echo "${GREEN}Starting documentation server at http://localhost:8000${NC}"
	@cd "$(DOCS_BUILD_DIR)/html" && python -m http.server 8000

# ====================================================================
# Help Target
# ====================================================================

help: ## Show this help message
	@echo "\n\033[1m{{ namespace_name }}.{{ collection_name }} - Documentation\033[0m"
	@echo "========================================"
	@echo "\n\033[1mAvailable Targets\033[0m"
	@echo "----------------"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \\033[36m%-20s\\033[0m %s\\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "\n\033[1mDocumentation Builders\033[0m"
	@echo "----------------------"
	@echo "  make html        - make standalone HTML files"
	@echo "  make dirhtml     - make HTML files named index.html in directories"
	@echo "  make singlehtml  - make a single large HTML file"
	@echo "  make pickle      - make pickle files"
	@echo "  make json        - make JSON files"
	@echo "  make htmlhelp    - make HTML files and a HTML help project"
	@echo "  make qthelp      - make HTML files and a qthelp project"
	@echo "  make devhelp     - make HTML files and a Devhelp project"
	@echo "  make epub        - make an epub"
	@echo "  make latex       - make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  make latexpdf    - make LaTeX files and run them through pdflatex"
	@echo "  make text        - make text files"
	@echo "  make man         - make manual pages"
	@echo "  make changes     - make an overview of all changed/added/deprecated items"
	@echo "  make linkcheck   - check all external links for integrity"
	@echo "  make doctest     - run all doctests embedded in the documentation"

# Set default target
.DEFAULT_GOAL := help
