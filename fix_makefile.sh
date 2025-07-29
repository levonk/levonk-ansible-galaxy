#!/bin/bash

# Fix the Makefile that was broken by multiple runs of fix_tr_command.sh
makefile_path="ansible-galaxy/Makefile"

# Backup the original file
cp "$makefile_path" "${makefile_path}.bak"

# Replace the problematic section with the correct version
# This ensures all quotes are properly terminated
cat > "$makefile_path" << 'EOF'
.PHONY: all build clean test beta prod lint lint-ansible lint-markdown lint-yaml lint-galaxy molecule debug-galaxy inst-src inst-repo inst-build inst-beta inst-prod new-collection new-role

# Define paths and collections
ROOT_DIR := $(shell pwd)
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

# Build all collections
build: $(BUILD_MARKER)

$(BUILD_MARKER): $(CLEAN_MARKER)
	@mkdir -p $(DIST_DIR)
	echo "Building collections: $(COLLECTIONS)"
	for collection in $(COLLECTIONS); do \
		echo "\n=== Building levonk.$$collection collection ==="; \
		if [ -f "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" ]; then \
			echo "Checking galaxy.yml for $$collection"; \
			GALAXY_NAME=$$(grep -E "^name:" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" | awk '{print $$2}' | tr -d '"' | tr -d "'"); \
			if [ "$$GALAXY_NAME" != "$$collection" ]; then \
				echo "Fixing galaxy.yml name from '$$GALAXY_NAME' to '$$collection'"; \
				sed -i "s/^name:.*/name: $$collection/" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			fi; \
			cd "$(COLLECTIONS_DIR)/$$collection"; \
			ansible-galaxy collection build --output-path "$(DIST_DIR)" --force; \
			RETVAL=$$?; \
			if [ $$RETVAL -ne 0 ]; then \
				echo "ERROR: Failed to build $$collection with existing galaxy.yml"; \
			else \
				echo "Successfully built $$collection with existing galaxy.yml"; \
			fi; \
			cd "$(ROOT_DIR)"; \
		else \
			echo "Creating galaxy.yml for $$collection"; \
			mkdir -p "$(COLLECTIONS_DIR)/$$collection"; \
			echo "---" > "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "namespace: levonk" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "name: $$collection" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "version: 1.0.0" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "readme: README.md" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "authors:" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "  - Levon Kachadourian" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "description: Levonk $$collection collection" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "license:" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "  - MIT" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "tags:" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "  - levonk" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "  - ansible" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "  - collection" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "repository: https://github.com/levonk/levonk-ansible-galaxy" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "documentation: https://github.com/levonk/levonk-ansible-galaxy" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "homepage: https://github.com/levonk/levonk-ansible-galaxy" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			echo "issues: https://github.com/levonk/levonk-ansible-galaxy/issues" >> "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; \
			if [ ! -f "$(COLLECTIONS_DIR)/$$collection/README.md" ]; then \
				echo "Creating README.md for $$collection"; \
				echo "# levonk.$$collection collection" > "$(COLLECTIONS_DIR)/$$collection/README.md"; \
				echo "" >> "$(COLLECTIONS_DIR)/$$collection/README.md"; \
				echo "Documentation for the $$collection collection." >> "$(COLLECTIONS_DIR)/$$collection/README.md"; \
			fi; \
			cd "$(COLLECTIONS_DIR)/$$collection"; \
			ansible-galaxy collection build --output-path "$(DIST_DIR)" --force; \
			RETVAL=$$?; \
			if [ $$RETVAL -ne 0 ]; then \
				echo "ERROR: Failed to build $$collection with new galaxy.yml"; \
			else \
				echo "Successfully built $$collection with new galaxy.yml"; \
			fi; \
			cd "$(ROOT_DIR)"; \
		fi; \
		echo "=== Finished processing $$collection ==="; \
	done
	echo "\nBuild process complete. Artifacts in $(DIST_DIR):"
	find "$(DIST_DIR)" -name "*.tar.gz" | sort

# Clean the dist directory
clean: | $(MARKER_DIR)
	@echo "Cleaning $(DIST_DIR)"
	@mkdir -p $(DIST_DIR)
	@rm -f $(DIST_DIR)/*.tar.gz
	@touch $(CLEAN_MARKER)

# Create marker directory
$(MARKER_DIR):
	@mkdir -p $(MARKER_DIR)

# Run tests
test: $(TEST_MARKER)

$(TEST_MARKER): $(LINT_MARKER)
	@echo "Running molecule tests"
	@$(MAKE) molecule
EOF

echo "Makefile has been fixed. Original is backed up as ${makefile_path}.bak"
