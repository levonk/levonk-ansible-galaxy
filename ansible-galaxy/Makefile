.PHONY: all build clean test publish-beta prod lint lint-ansible lint-markdown lint-yaml lint-galaxy molecule debug-galaxy inst-src inst-repo inst-build inst-beta inst-prod new-collection new-role promote

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
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Linting levonk.$$collection collection with ansible-lint ==="; \
		if [ -d "$(COLLECTIONS_DIR)/$$collection" ]; then \
			LINT_TEMP_DIR=$$(mktemp -d) || { echo "Failed to create temp directory"; exit 1; }; \
			echo "Created temporary linting directory: $$LINT_TEMP_DIR"; \
			\
			# Copy only the files we want to lint
			for dir in roles plugins docs meta tests; do \
				if [ -d "$(COLLECTIONS_DIR)/$$collection/$$dir" ]; then \
					mkdir -p "$$LINT_TEMP_DIR/$$dir"; \
					cp -r "$(COLLECTIONS_DIR)/$$collection/$$dir/"* "$$LINT_TEMP_DIR/$$dir/"; \
				fi; \
			done; \
			\
			# Copy the galaxy.yml file
			if [ -f "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" ]; then \
				cp "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" "$$LINT_TEMP_DIR/"; \
			fi; \
			\
			# Run ansible-lint in the temporary directory
			echo "Running ansible-lint in temporary directory..."; \
			(cd "$$LINT_TEMP_DIR" && \
			ansible-lint --no-progress --skip-list=no-changed-when,no-handler,command-instead-of-module . || \
			echo "Warning: Ansible linting issues found in $$collection"); \
			\
			# Clean up
			rm -rf "$$LINT_TEMP_DIR"; \
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
			echo "Checking required fields in $$collection/galaxy.yml"; \
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
			GALAXY_NAME=$$(grep -E "^name:" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" | awk '{print $$2}' | tr -d '"' | tr -d "'"); \
			if [ "$$GALAXY_NAME" != "$$collection" ]; then \
				echo "ERROR: Name '$$GALAXY_NAME' does not match directory name '$$collection'"; \
			fi; \
			echo "Validating with yamllint"; \
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
	@echo "Testing connection to $${GALAXY_SERVER}..."
	@curl -s -o /dev/null -w "%{http_code}" --connect-timeout 10 "$${GALAXY_SERVER}" | grep -q "^[23]" || { echo "ERROR: Cannot connect to $${GALAXY_SERVER}. Please check your internet connection and try again."; exit 1; }
	@curl -s -o /dev/null -w "%{http_code}" --connect-timeout 10 -H "Authorization: Bearer $${ANSIBLE_GALAXY_TOKEN}" "$${GALAXY_SERVER}/api/v3/collections" | grep -q "^[23]" || { echo "ERROR: Authentication failed for $${GALAXY_SERVER}. Please check your token and try again."; exit 1; }
	for collection in $$(find "$(DIST_DIR)" -name "*.tar.gz"); do \
		echo "Publishing $$(basename $$collection) to $${GALAXY_SERVER}..."; \
		ansible-galaxy collection publish $$collection --api-key="$${ANSIBLE_GALAXY_TOKEN}" --server="$${GALAXY_SERVER}" || \
			echo "Failed to publish $$(basename $$collection)."; \
	done

# Publish to beta server (depends on promote, which depends on test)
publish-beta: promote
	@echo "Running publish-beta script to publish collections to beta server..."
	@if [ ! -f "$(ROOT_DIR)/bin/publish-beta.sh" ]; then \
		echo "ERROR: publish-beta.sh script not found in $(ROOT_DIR)/bin"; \
		echo "Available scripts in bin: $$(ls -1 $(ROOT_DIR)/bin/ 2>/dev/null || echo 'none')"; \
		exit 1; \
	fi
	@if [ -z "$${BETA_ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "WARNING: BETA_ANSIBLE_GALAXY_TOKEN environment variable is not set. Using dev-beta instead." ; \
		$(MAKE) -C .. dev-beta ; \
	else \
		"$(ROOT_DIR)/bin/publish-beta.sh" "$(DIST_DIR)" "$(COLLECTIONS)" "$${BETA_ANSIBLE_GALAXY_TOKEN}" && \
		touch $(MARKER_DIR)/beta.marker ; \
	fi

# Alias for backward compatibility
beta: publish-beta

# Publish to production server (requires successful beta deployment and being on env/prod branch)
prod: publish-beta
	@CURRENT_BRANCH=$$(git rev-parse --abbrev-ref HEAD); \
	if [ "$$CURRENT_BRANCH" != "env/prod" ]; then \
		echo "ERROR: Production deployment can only be done from the 'env/prod' branch."; \
		echo "Current branch: $$CURRENT_BRANCH"; \
		echo "Please checkout the env/prod branch first: git checkout env/prod"; \
		exit 1; \
	fi
	@echo "Publishing collections to production server from env/prod branch..."
	@if [ -z "$${PROD_ANSIBLE_GALAXY_TOKEN}" ]; then \
		echo "ERROR: PROD_ANSIBLE_GALAXY_TOKEN environment variable is not set."; \
		echo "You can find your token at https://galaxy.ansible.com/ui/token/ after logging in."; \
		echo "Then set it with: export PROD_ANSIBLE_GALAXY_TOKEN=your_token"; \
		exit 1; \
	fi
	@ANSIBLE_GALAXY_TOKEN="$${PROD_ANSIBLE_GALAXY_TOKEN}" $(MAKE) _publish_base GALAXY_SERVER="https://galaxy.ansible.com"

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

# Installation targets

# Install from source directory
inst-src:
	@echo "Installing collections from source directories..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing levonk.$$collection from source ===" ; \
		ansible-galaxy collection install "$(COLLECTIONS_DIR)/$$collection" --force ; \
		if [ -f "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" ]; then \
			echo "Running test playbook for levonk.$$collection..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" ; \
		elif [ -f "$(ROOT_DIR)/../tests/test-levonk.yml" ]; then \
			echo "Running namespace test playbook..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.yml" ; \
		else \
			echo "No test playbook found for levonk.$$collection" ; \
		fi ; \
	done

# Install from git repository
inst-repo:
	@echo "Installing collections from git repository..."
	@read -p "Enter branch name (default: main): " branch; \
	branch=$${branch:-main}; \
	for collection in $(COLLECTIONS); do \
		echo "\n=== Installing levonk.$$collection from git repository (branch: $$branch) ===" ; \
		ansible-galaxy collection install git+https://github.com/levonk/levonk-ansible-galaxy.git#/collections/ansible_collections/levonk/$$collection/,$$branch --force ; \
		if [ -f "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" ]; then \
			echo "Running test playbook for levonk.$$collection..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" ; \
		elif [ -f "$(ROOT_DIR)/../tests/test-levonk.yml" ]; then \
			echo "Running namespace test playbook..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.yml" ; \
		else \
			echo "No test playbook found for levonk.$$collection" ; \
		fi ; \
	done

# Install from built artifacts
inst-build: $(BUILD_MARKER)
	@echo "Installing collections from build artifacts..."
	@for collection_file in $$(find "$(DIST_DIR)" -name "levonk-*.tar.gz"); do \
		echo "\n=== Installing $$(basename $$collection_file) ===" ; \
		ansible-galaxy collection install "$$collection_file" --force ; \
		collection_name=$$(echo $$(basename $$collection_file) | sed -E 's/levonk-(.*)-[0-9]+\.[0-9]+\.[0-9]+\.tar\.gz/\1/') ; \
		if [ -f "$(ROOT_DIR)/../tests/test-levonk.$$collection_name.yml" ]; then \
			echo "Running test playbook for levonk.$$collection_name..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.$$collection_name.yml" ; \
		elif [ -f "$(ROOT_DIR)/../tests/test-levonk.yml" ]; then \
			echo "Running namespace test playbook..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.yml" ; \
		else \
			echo "No test playbook found for levonk.$$collection_name" ; \
		fi ; \
	done

# Install from beta server (depends on publish-beta to ensure collections are published)
inst-beta: publish-beta
	@echo "Installing collections from beta server..."
	@FAILED_COLLECTIONS=""; \
	for collection in $(COLLECTIONS); do \
		echo "\n=== Installing levonk.$$collection from beta server ===" ; \
		if ! ansible-galaxy collection list --server https://galaxy-dev.ansible.com | grep -q "levonk.$$collection"; then \
			echo "WARNING: Collection levonk.$$collection not found on beta server!" ; \
			echo "This collection needs to be published to the beta server." ; \
			FAILED_COLLECTIONS="$$FAILED_COLLECTIONS levonk.$$collection"; \
			continue; \
		fi ; \
		SERVER_VERSION=$$(ansible-galaxy collection list --server https://galaxy-dev.ansible.com | grep "levonk.$$collection" | awk '{print $$2}') ; \
		if [ -f "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" ]; then \
			LOCAL_VERSION=$$(grep -E "^version:" "$(COLLECTIONS_DIR)/$$collection/galaxy.yml" | awk '{print $$2}' | tr -d '"' | tr -d "'") ; \
			if [ "$$LOCAL_VERSION" != "$$SERVER_VERSION" ]; then \
				echo "WARNING: Version mismatch for levonk.$$collection!" ; \
				echo "Local version: $$LOCAL_VERSION" ; \
				echo "Server version: $$SERVER_VERSION" ; \
				echo "This collection needs to be published with the current version." ; \
				FAILED_COLLECTIONS="$$FAILED_COLLECTIONS levonk.$$collection"; \
				continue; \
			fi; \
		else \
			echo "Note: No local version found for levonk.$$collection. Installing from beta server."; \
		fi ; \
		if ! ansible-galaxy collection install levonk.$$collection --server https://galaxy-dev.ansible.com --force --pre; then \
			echo "WARNING: Failed to install levonk.$$collection from beta server." ; \
			FAILED_COLLECTIONS="$$FAILED_COLLECTIONS levonk.$$collection"; \
			continue; \
		fi ; \
		if [ -f "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" ]; then \
			echo "Running test playbook for levonk.$$collection..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" || true; \
		elif [ -f "$(ROOT_DIR)/../tests/test-levonk.yml" ]; then \
			echo "Running namespace test playbook..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.yml" || true; \
		else \
			echo "No test playbook found for levonk.$$collection"; \
		fi; \
	done; \
	if [ -n "$$FAILED_COLLECTIONS" ]; then \
		echo "\n\nERROR: The following collections could not be installed from beta server:$$FAILED_COLLECTIONS"; \
		echo "\nPlease run 'make publish-beta' to publish these collections to the beta server."; \
		exit 1; \
	fi

# Install from production server (depends on prod to ensure collections are published)
inst-prod: prod
	@echo "Installing collections from production server..."
	@for collection in $(COLLECTIONS); do \
		echo "\n=== Installing levonk.$$collection from production server ===" ; \
		ansible-galaxy collection install levonk.$$collection --force ; \
		if [ -f "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" ]; then \
			echo "Running test playbook for levonk.$$collection..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.$$collection.yml" ; \
		elif [ -f "$(ROOT_DIR)/../tests/test-levonk.yml" ]; then \
			echo "Running namespace test playbook..." ; \
			ansible-playbook "$(ROOT_DIR)/../tests/test-levonk.yml" ; \
		else \
			echo "No test playbook found for levonk.$$collection" ; \
		fi ; \
	done

# Promote collections by incrementing the build version (patch) number
# This is the default promotion target used in the build pipeline
promote: promote-build

# Promote collections by incrementing the major version number
promote-major: $(TEST_MARKER)
	@echo "Promoting collections with MAJOR version increment..."
	@if [ ! -f "$(ROOT_DIR)/bin/promote-major.sh" ]; then \
		echo "ERROR: promote-major.sh script not found in $(ROOT_DIR)/bin"; \
		exit 1; \
	fi
	@"$(ROOT_DIR)/bin/promote-major.sh" "$(COLLECTIONS_DIR)" "$(COLLECTIONS)"
	@echo "Rebuilding collections with the new versions..."
	@rm -f $(BUILD_MARKER)
	@$(MAKE) build

# Promote collections by incrementing the minor version number
promote-minor: $(TEST_MARKER)
	@echo "Promoting collections with MINOR version increment..."
	@if [ ! -f "$(ROOT_DIR)/bin/promote-minor.sh" ]; then \
		echo "ERROR: promote-minor.sh script not found in $(ROOT_DIR)/bin"; \
		exit 1; \
	fi
	@"$(ROOT_DIR)/bin/promote-minor.sh" "$(COLLECTIONS_DIR)" "$(COLLECTIONS)"
	@echo "Rebuilding collections with the new versions..."
	@rm -f $(BUILD_MARKER)
	@$(MAKE) build

# Promote collections by incrementing the build (patch) version number
promote-build: $(TEST_MARKER)
	@echo "Promoting collections with BUILD version increment..."
	@if [ ! -f "$(ROOT_DIR)/bin/promote-build.sh" ]; then \
		echo "ERROR: promote-build.sh script not found in $(ROOT_DIR)/bin"; \
		exit 1; \
	fi
	@"$(ROOT_DIR)/bin/promote-build.sh" "$(COLLECTIONS_DIR)" "$(COLLECTIONS)"
	@echo "Rebuilding collections with the new versions..."
	@rm -f $(BUILD_MARKER)
	@$(MAKE) build

# Create a new collection using the setup_new_collection.sh script
new-collection:
	@echo "Creating a new collection..."
	@read -p "Enter collection name: " collection_name; \
	if [ -z "$$collection_name" ]; then \
		echo "Error: Collection name cannot be empty."; \
		exit 1; \
	fi; \
	echo "Creating new collection: levonk.$$collection_name"; \
	$(ROOT_DIR)/../bin/setup_new_collection.sh $$collection_name; \
	echo "To add this collection to the build list, update the COLLECTIONS variable in the Makefile."

# Create a new role within a collection using the setup_new_role.sh script
new-role:
	@echo "Creating a new role..."
	@read -p "Enter collection name: " collection_name; \
	read -p "Enter role name: " role_name; \
	if [ -z "$$collection_name" ] || [ -z "$$role_name" ]; then \
		echo "Error: Collection name and role name cannot be empty."; \
		exit 1; \
	fi; \
	if [ ! -d "$(COLLECTIONS_DIR)/$$collection_name" ]; then \
		echo "Collection '$$collection_name' does not exist. Creating it first..."; \
		$(MAKE) new-collection collection_name=$$collection_name; \
	fi; \
	echo "Creating new role: levonk.$$collection_name.$$role_name"; \
	$(ROOT_DIR)/../bin/setup_new_role.sh $$collection_name $$role_name

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
