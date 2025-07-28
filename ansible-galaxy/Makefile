.PHONY: all build clean test beta prod lint lint-ansible lint-markdown lint-yaml lint-galaxy molecule debug-galaxy

# Define paths and collections
ROOT_DIR := $(shell pwd)
COLLECTIONS_DIR := $(ROOT_DIR)/collections/ansible_collections/levonk
DIST_DIR := $(ROOT_DIR)/../dist
COLLECTIONS := base_system common gamer hardened server-llmchat user_setup vibeops

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
			GALAXY_NAME=$$(grep -E "^name:" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" | awk '{print $$2}' | tr -d '"\'''); \
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
	@touch $(TEST_MARKER)

# Main lint target that runs all linting tools
lint: $(LINT_MARKER)

$(LINT_MARKER): $(BUILD_MARKER)
	@echo "Running all linting tools"
	@$(MAKE) lint-ansible
	@$(MAKE) lint-markdown
	@$(MAKE) lint-yaml
	@$(MAKE) lint-galaxy
	@echo "All linting completed."
	@touch $(LINT_MARKER)

# Lint Ansible files with ansible-lint
lint-ansible:
	@echo "Linting Ansible files..."
	for collection in $(COLLECTIONS); do \
		echo "\n=== Linting levonk.$$collection collection with ansible-lint ===" ; \
		if [ -d "$(COLLECTIONS_DIR)/$$collection" ]; then \
			cd "$(COLLECTIONS_DIR)/$$collection" && \
			ansible-lint . || echo "Warning: Ansible linting issues found in $$collection"; \
			cd "$(ROOT_DIR)"; \
		else \
			echo "Collection directory not found for $$collection"; \
		fi; \
	done

# Lint Markdown files with markdownlint
lint-markdown:
	@echo "Linting Markdown files..."
	for collection in $(COLLECTIONS); do \
		echo "\n=== Linting Markdown files in levonk.$$collection ===" ; \
		if [ -d "$(COLLECTIONS_DIR)/$$collection" ]; then \
			find "$(COLLECTIONS_DIR)/$$collection" -name "*.md" -type f -exec echo "Checking {}" \; -exec markdownlint {} \; || \
				echo "Warning: Markdown linting issues found in $$collection"; \
		else \
			echo "Collection directory not found for $$collection"; \
		fi; \
	done

# Lint YAML files with yamllint
lint-yaml:
	@echo "Linting YAML files..."
	for collection in $(COLLECTIONS); do \
		echo "\n=== Linting YAML files in levonk.$$collection ===" ; \
		if [ -d "$(COLLECTIONS_DIR)/$$collection" ]; then \
			find "$(COLLECTIONS_DIR)/$$collection" -name "*.yml" -o -name "*.yaml" -type f -exec echo "Checking {}" \; -exec yamllint {} \; || \
				echo "Warning: YAML linting issues found in $$collection"; \
		else \
			echo "Collection directory not found for $$collection"; \
		fi; \
	done

# Specific linting for galaxy.yml files
lint-galaxy:
	@echo "Linting galaxy.yml files..."
	for collection in $(COLLECTIONS); do \
		echo "\n=== Checking galaxy.yml for levonk.$$collection ===" ; \
		if [ -f "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" ]; then \
			echo "Checking required fields in $$collection/galaxy.yml"
			for field in namespace name version readme authors description license; do \
				if ! grep -q "^$$field:" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; then \
					echo "ERROR: Missing required field '$$field' in galaxy.yml for $$collection"; \
				fi; \
			done; \
			echo "Verifying namespace is 'levonk'"; \
			if ! grep -q "^namespace: levonk" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml"; then \
				echo "ERROR: Namespace must be 'levonk' in galaxy.yml for $$collection"; \
			fi; \
			echo "Verifying name matches directory name"; \
			GALAXY_NAME=$$(grep -E "^name:" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" | awk '{print $$2}' | tr -d '"\'''); \
			if [ "$$GALAXY_NAME" != "$$collection" ]; then \
				echo "ERROR: Name '$$GALAXY_NAME' does not match directory name '$$collection'"; \
			fi; \
			echo "Validating with yamllint"
			yamllint "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" || echo "Warning: YAML syntax issues in galaxy.yml for $$collection"; \
		else \
			echo "galaxy.yml not found for $$collection"; \
		fi; \
	done

# Run molecule tests
molecule:
	@echo "Running molecule tests..."
	for collection in $(COLLECTIONS); do \
		echo "\n=== Running molecule tests for levonk.$$collection collection ==="; \
		for role_dir in $$(find "$(COLLECTIONS_DIR)/$$collection/roles" -mindepth 1 -maxdepth 1 -type d 2>/dev/null); do \
			role_name=$$(basename "$$role_dir"); \
			if [ -d "$$role_dir/molecule" ]; then \
				echo "Testing role: $$role_name"; \
				cd "$$role_dir" && \
				molecule test || echo "Warning: Molecule tests failed for $$role_name"; \
				cd "$(ROOT_DIR)"; \
			else \
				echo "No molecule tests found for role: $$role_name"; \
			fi; \
		done; \
	done

# Base publish target - not meant to be called directly
_publish_base:
	@if [ -z "$${ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "WARNING: ANSIBLE_GALAXY_TOKEN environment variable is not set."; \
		echo "You can find your token at https://galaxy.ansible.com/ui/token/ after logging in."; \
		echo "Then set it with: export ANSIBLE_GALAXY_TOKEN=your_token"; \
		echo "Skipping actual publishing step for development purposes."; \
		echo "Set ANSIBLE_GALAXY_TOKEN to publish collections."; \
		ANSIBLE_GALAXY_TOKEN="dummy_token_for_dev"; \
	fi
	@if [ -z "$${GALAXY_SERVER}" ]; then \
		echo "WARNING: GALAXY_SERVER variable is not set."; \
		echo "Using default beta server for development purposes."; \
		GALAXY_SERVER="$(GALAXY_BETA_SERVER)"; \
	fi
	@echo "Using ANSIBLE_GALAXY_TOKEN for authentication to $${GALAXY_SERVER}"
	for collection in $$(find "$(DIST_DIR)" -name "*.tar.gz"); do \
		echo "Publishing $$(basename $$collection) to $${GALAXY_SERVER}..."; \
		ansible-galaxy collection publish $$collection --api-key="$${ANSIBLE_GALAXY_TOKEN}" --server="$${GALAXY_SERVER}" || \
			echo "Failed to publish $$(basename $$collection)."; \
	done

# Publish to beta server
beta: $(TEST_MARKER)
	@echo "Publishing collections to beta server..."
	@echo "Using beta server URL: https://galaxy-dev.ansible.com"
	@if [ -z "$${ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "WARNING: ANSIBLE_GALAXY_TOKEN environment variable is not set. Using dev-beta instead." ; \
		$(MAKE) -C .. dev-beta ; \
	else \
		echo "Token prefix: $$(echo $${ANSIBLE_GALAXY_TOKEN} | cut -c1-3)..." ; \
		for collection in $$(find "$(DIST_DIR)" -name "*.tar.gz"); do \
			echo "Publishing $$(basename $$collection) to https://galaxy-dev.ansible.com..." ; \
			ansible-galaxy collection publish $$collection --api-key="$${ANSIBLE_GALAXY_TOKEN}" --server="https://galaxy-dev.ansible.com" || \
			echo "Failed to publish $$(basename $$collection)." ; \
		done ; \
		touch $(MARKER_DIR)/beta.marker ; \
	fi

# Publish to production server (requires successful beta deployment and being on env/prod branch)
prod: $(MARKER_DIR)/beta.marker
	@CURRENT_BRANCH=$$(git rev-parse --abbrev-ref HEAD); \
	if [ "$$CURRENT_BRANCH" != "env/prod" ]; then \
		echo "ERROR: Production deployment can only be done from the 'env/prod' branch."; \
		echo "Current branch: $$CURRENT_BRANCH"; \
		echo "Please checkout the env/prod branch first: git checkout env/prod"; \
		exit 1; \
	fi
	@echo "Publishing collections to production server from env/prod branch..."
	@$(MAKE) _publish_base GALAXY_SERVER="https://galaxy.ansible.com"

# List all collections
list:
	@echo "Available collections in levonk namespace:"
	@for collection in $(COLLECTIONS); do \
		echo " - $$collection" ; \
	done

# Reset all markers to force full rebuild
reset:
	@echo "Resetting all build markers"
	@rm -rf $(MARKER_DIR)
	@mkdir -p $(MARKER_DIR)
	@echo "All markers reset. Next build will run all steps."

# Debug target for Galaxy authentication
debug-galaxy:
	@echo "Running Galaxy authentication debugging tool..."
	@$(ROOT_DIR)/../bin/galaxy_auth_tool.sh --server="https://galaxy-dev.ansible.com"

# Debug target to print variables
debug:
	@echo "ROOT_DIR: $(ROOT_DIR)"
	@echo "COLLECTIONS_DIR: $(COLLECTIONS_DIR)"
	@echo "DIST_DIR: $(DIST_DIR)"
	@echo "COLLECTIONS: $(COLLECTIONS)"
	@echo "MARKER_DIR: $(MARKER_DIR)"
	@echo "\nMarker files status:"
	@echo "- Clean:  $$([ -f $(CLEAN_MARKER) ] && echo 'Done' || echo 'Not done')"
	@echo "- Build:  $$([ -f $(BUILD_MARKER) ] && echo 'Done' || echo 'Not done')"
	@echo "- Lint:   $$([ -f $(LINT_MARKER) ] && echo 'Done' || echo 'Not done')"
	@echo "- Test:   $$([ -f $(TEST_MARKER) ] && echo 'Done' || echo 'Not done')"
	@echo "- Beta:   $$([ -f $(MARKER_DIR)/beta.marker ] && echo 'Done' || echo 'Not done')"
	@echo "\nCollection directories:"
	@for collection in $(COLLECTIONS); do \
		echo "- $$collection: $(COLLECTIONS_DIR)/$$collection"; \
	done
	@echo "\nBuild artifacts:"
	@find "$(DIST_DIR)" -name "*.tar.gz" -exec basename {} \; | sort 2>/dev/null || echo "No build artifacts found"
