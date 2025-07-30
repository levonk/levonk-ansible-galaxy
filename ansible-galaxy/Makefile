.PHONY: all build clean test publish-beta prod lint lint-ansible lint-markdown lint-yaml lint-galaxy molecule debug-galaxy inst-src inst-repo inst-build inst-beta inst-prod new-collection new-role promote

# Tool checking - these will be empty if not found
HAS_ANSIBLE_LINT := $(shell command -v ansible-lint 2> /dev/null)
HAS_MOLECULE := $(shell command -v molecule 2> /dev/null)
HAS_YAMLLINT := $(shell command -v yamllint 2> /dev/null)

# Track if we've shown warnings for missing tools
TOOL_WARNINGS_SHOWN := 0

# Function to check and warn about a missing tool once
check_tool = \
    if [ "$(TOOL_WARNINGS_SHOWN)" -eq 0 ] && [ -z "$($1)" ]; then \
        echo "WARNING: $1 is not installed. Some functionality may be limited."; \
        TOOL_WARNINGS_SHOWN=1; \
    fi

# Define paths and collections
ROOT_DIR := $(shell pwd)
BIN_DIR := $(ROOT_DIR)/../bin

# Include additional targets
include Makefile.targets
COLLECTIONS_DIR := $(ROOT_DIR)/collections/ansible_collections/levonk
DIST_DIR := $(ROOT_DIR)/../dist
COLLECTIONS := base_system common gamer hardened server_llmchat user_setup vibeops

# Define marker files for tracking completion of steps
MARKER_DIR := $(ROOT_DIR)/.markers
CLEAN_MARKER := $(MARKER_DIR)/clean.marker
LINT_MARKER := $(MARKER_DIR)/lint.marker
BUILD_MARKER := $(MARKER_DIR)/build.marker
TEST_MARKER := $(MARKER_DIR)/test.marker

all: build test

# Enable verbose output with V=1
ifneq (,$(filter-out 0,$(V)))
  QUIET =
else
  QUIET = @
  MAKEFLAGS += --no-print-directory
endif

# Enable non-fatal mode with NO_FAIL=1
ifneq (,$(filter-out 0,$(NO_FAIL)))
  NO_FAIL_OPT = true
  NO_FAIL_MSG = " (failures ignored)"
else
  NO_FAIL_OPT = false
  NO_FAIL_MSG =
endif

# Function to print status messages
define print_status
  $(if $(QUIET),@echo "[BUILD] $(1)",@echo -n "[BUILD] $(1)... ")
endef

define print_ok
  $(if $(QUIET),,@echo "OK")
endef

define print_fail
  $(if $(QUIET),,@echo "FAILED")
endef

# Build all collections
build: $(BUILD_MARKER)

$(BUILD_MARKER): $(CLEAN_MARKER)
	@echo "[BUILD] Building collections: $(COLLECTIONS)"
	@mkdir -p $(DIST_DIR)
	@for collection in $(COLLECTIONS); do \
		echo "[BUILD] Processing collection: $$collection"; \
		if [ -f "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" ]; then \
			GALAXY_NAME=$$(grep -E "^name:" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" | awk '{print $$2}' | tr -d '"' | tr -d "'"); \
			if [ "$$GALAXY_NAME" != "$$collection" ]; then \
				echo "[BUILD] Updating galaxy.yml name from $$GALAXY_NAME to $$collection"; \
				sed -i "s/^name:.*/name: $$collection/" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			fi; \
			echo -n "[BUILD] Building $$collection... "; \
			if (cd "$(COLLECTIONS_DIR)/$$collection" && \
			    ansible-galaxy collection build --output-path "$(DIST_DIR)" --force >/dev/null 2>&1); then \
				echo "OK"; \
			else \
				echo "FAILED"; \
				exit 1; \
			fi; \
			cd - >/dev/null; \
		else \
			echo "[BUILD] Creating new collection: $$collection"; \
			mkdir -p "$(COLLECTIONS_DIR)/$$collection"; \
			{ \
				echo "---"; \
				echo "namespace: levonk"; \
				echo "name: $$collection"; \
				echo "version: 1.0.0"; \
				echo "readme: README.md"; \
				echo "authors:"; \
				echo "  - Levon Kachadourian"; \
				echo "description: Levonk $$collection collection"; \
				echo "license:"; \
				echo "  - MIT"; \
				echo "tags:"; \
				echo "  - levonk"; \
				echo "  - ansible"; \
				echo "  - collection"; \
				echo "repository: https://github.com/levonk/levonk-ansible-galaxy"; \
				echo "documentation: https://github.com/levonk/levonk-ansible-galaxy"; \
				echo "homepage: https://github.com/levonk/levonk-ansible-galaxy"; \
				echo "issues: https://github.com/levonk/levonk-ansible-galaxy/issues"; \
			} > "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			[ ! -f "$(COLLECTIONS_DIR)/$$collection/README.md" ] && \
				echo -e "# levonk.$$collection collection\n\nDocumentation for the $$collection collection." > "$(COLLECTIONS_DIR)/$$collection/README.md"; \
			cd "$(COLLECTIONS_DIR)/$$collection" && \
			ansible-galaxy collection build --output-path "$(DIST_DIR)" --force >/dev/null 2>&1; \
			if [ $$? -eq 0 ]; then \
				echo "[BUILD] Successfully created and built $$collection"; \
			else \
				echo "[BUILD] Failed to build new collection: $$collection"; \
				exit 1; \
			fi; \
			cd - >/dev/null; \
		fi; \
	done
	@echo "[BUILD] Build complete. Artifacts in $(DIST_DIR):"
	@find "$(DIST_DIR)" -name "*.tar.gz" -exec basename {} \; | sort

# Clean the dist directory
clean: | $(MARKER_DIR)
	@echo "[CLEAN] Removing built collections"
	@mkdir -p $(DIST_DIR)
	@rm -f $(DIST_DIR)/*.tar.gz
	@touch $(CLEAN_MARKER)

# Create marker directory
$(MARKER_DIR):
	@mkdir -p $(MARKER_DIR)

# Run tests
test: $(TEST_MARKER)

$(TEST_MARKER): $(LINT_MARKER)
	@echo "Running molecule tests$(NO_FAIL_MSG)"
	@if [ "$(NO_FAIL_OPT)" = "true" ]; then \
		$(MAKE) molecule || echo "[WARNING] Tests failed but continuing due to NO_FAIL=1"; \
	else \
		$(MAKE) molecule; \
	fi
	@touch $(TEST_MARKER)

# Main lint target that runs all linting tools
# Run with NO_FAIL=1 to continue on errors
lint: $(LINT_MARKER)

$(LINT_MARKER): $(BUILD_MARKER)
	@echo "Running all linting tools$(NO_FAIL_MSG)"
	@if [ "$(NO_FAIL_OPT)" = "true" ]; then \
		$(MAKE) lint-ansible || echo "[WARNING] ansible-lint failed but continuing due to NO_FAIL=1"; \
		$(MAKE) lint-markdown || echo "[WARNING] markdownlint failed but continuing due to NO_FAIL=1"; \
		$(MAKE) lint-yaml || echo "[WARNING] yamllint failed but continuing due to NO_FAIL=1"; \
		$(MAKE) lint-galaxy || echo "[WARNING] galaxy validation failed but continuing due to NO_FAIL=1"; \
	else \
		$(MAKE) lint-ansible; \
		$(MAKE) lint-markdown; \
		$(MAKE) lint-yaml; \
		$(MAKE) lint-galaxy; \
	fi
	@echo "All linting completed.$(if $(NO_FAIL_MSG), $(NO_FAIL_MSG))"
	@touch $(LINT_MARKER)

# Lint Ansible files with ansible-lint
# Run with V=1 for verbose output
# Run with NO_FAIL=1 to continue on errors
.PHONY: lint-ansible
lint-ansible:
	@COLLECTIONS_DIR="$(COLLECTIONS_DIR)" \
	 QUIET="$(QUIET)" \
	 VERBOSE="$(V:1=1)" \
	 NO_FAIL="$(NO_FAIL_OPT:true=true)" \
	 $(BIN_DIR)/lint-ansible.sh

# Lint Markdown files with markdownlint
# Run with V=1 for verbose output
# Run with NO_FAIL=1 to continue on errors
.PHONY: lint-markdown
lint-markdown:
	@COLLECTIONS_DIR="$(COLLECTIONS_DIR)" \
	 QUIET="$(QUIET)" \
	 VERBOSE="$(V:1=1)" \
	 NO_FAIL="$(NO_FAIL_OPT:true=true)" \
	 $(BIN_DIR)/lint-markdown.sh

# Lint YAML files with yamllint
# Run with V=1 for verbose output
# Run with NO_FAIL=1 to continue on errors
.PHONY: lint-yaml
lint-yaml:
	@COLLECTIONS_DIR="$(COLLECTIONS_DIR)" \
	 QUIET="$(QUIET)" \
	 VERBOSE="$(V:1=1)" \
	 NO_FAIL="$(NO_FAIL_OPT:true=true)" \
	 $(BIN_DIR)/lint-yaml.sh

# Validate galaxy.yml files
# Run with V=1 for verbose output
# Run with NO_FAIL=1 to continue on errors
.PHONY: lint-galaxy
lint-galaxy:
	@COLLECTIONS_DIR="$(COLLECTIONS_DIR)" \
	 QUIET="$(QUIET)" \
	 VERBOSE="$(V:1=1)" \
	 NO_FAIL="$(NO_FAIL_OPT:true=true)" \
	 $(BIN_DIR)/lint-galaxy.sh

# Publish collections to beta server
publish-beta: promote
	@echo "Running publish-beta script to publish collections to beta server..."
	@if [ ! -f "$(BIN_DIR)/publish10-beta.sh" ]; then \
		echo "ERROR: publish10-beta.sh script not found in $(BIN_DIR)"; \
		exit 1; \
	fi
	@if [ -z "$${BETA_ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "ERROR: BETA_ANSIBLE_GALAXY_TOKEN environment variable is not set"; \
		echo "Please set it with: export BETA_ANSIBLE_GALAXY_TOKEN='your_token_here'"; \
		exit 1; \
	fi
	@echo "Publishing collections to beta server: $(COLLECTIONS)"
	@"$(BIN_DIR)/publish10-beta.sh" "$(COLLECTIONS)" "$${BETA_ANSIBLE_GALAXY_TOKEN}" "$(DIST_DIR)"

# Alias for publish-beta
beta: publish-beta

# Publish collections to production server
prod: publish-beta
	@echo "Running publish-prod script to publish collections to production server..."
	@if [ ! -f "$(BIN_DIR)/publish20-prod.sh" ]; then \
		echo "ERROR: publish20-prod.sh script not found in $(BIN_DIR)"; \
		exit 1; \
	fi
	@if [ -z "$${GALAXY_TOKEN}" ]; then \
		echo "ERROR: GALAXY_TOKEN environment variable is not set"; \
		echo "Please set it with: export GALAXY_TOKEN='your_token_here'"; \
		echo "Note: This is the production token, not the beta token"; \
		exit 1; \
	fi
	@echo "Publishing collections to production server: $(COLLECTIONS)"
	@"$(BIN_DIR)/publish20-prod.sh" "$(COLLECTIONS)" "$${GALAXY_TOKEN}" "$(DIST_DIR)"

