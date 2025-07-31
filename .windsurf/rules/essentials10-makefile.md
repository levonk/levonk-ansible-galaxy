---
trigger: model_decision
description: Use when working on the project's build system involving tools similar to `make`
---

# Make & Makefiles
Here's a generalized set of guidelines and best practices for structuring Makefiles in software projects. These are designed to promote maintainability, readability, and consistency across all your projects.

**I. Core Principles**

*   **Centralized Scripting:**  All non-.PHONY executable logic resides in scripts within a designated `/bin` directory (or a similar dedicated directory structure for scripts). This is not necessary for things like help/usage. The `Makefile` primarily orchestrates these scripts, managing dependencies and sequencing.
*   **Makefile as Orchestrator:** The `Makefile` *only* handles dependency management and the *order* of execution. Avoid complex shell scripting *within* the Makefile.
*   **Standardized Targets:**  Every `Makefile` across all projects *must* implement a common set of targets.
*   **Documentation-Driven:**  Every target in a `Makefile` *must* be documented in the project's `README.md` file and the `help` target.
*   **Copier-Friendly:**  The boilerplate Makefiles should be designed to work seamlessly with `copier` for easy project creation and updates.
*   **DRY (Don't Repeat Yourself):**  Maximize code reuse and avoid duplication through variables, functions, and included files.
*   **Graceful Failure:**  Make targets should fail gracefully, providing informative error messages and avoiding unintentional side effects.
*   **Makefiles until Module level:**  For every step down the tree of the project there should be a Makefile down to the module level. Calling `make` at the module level will operate solely on the module. Calling `make` at the collection or library level will solely operate on the library and all of it's children modules. Calling `make` on the application level will operate on the app, all it's libraries in the same repo, and all of the modules that are relied on in the same repo.

**II.  Mandatory Makefile Targets**

The following targets *must* be present in every `Makefile` and execute corresponding scripts in the `/bin` directory:

*   **`clean`:**  Removes generated files (object files, executables, temporary files, etc.).
*   **`archive`:** Creates an archive of the project (e.g., a `7z` file).  This assumes the existence of an archiving script in `/bin`.
*   **`all`:** Builds the entire project.  This is often the default target, but can also be used for a specific configuration, defaulting to dev (development).
*   **`help` aka `usage`:** Displays a list of available targets with brief descriptions.  (See auto-generation details below).
*   **`check`:** Runs static analysis tools and other checks to ensure code quality and consistency.
*   **`format`:**  Formats the code according to project coding standards.
*   **`test`:**  Runs all unit tests.
*   **`lint`:**  Runs all linting tools to identify potential code issues. There should be individual targets for each type of lint that the main 
*   **`coverage`:** Generates code coverage reports.
*   **`version`:** Displays the current project version.
*   **`status`:** Shows the current status of the project (e.g., Git branch, commit hash, build status).
*   **`watch`:**  Monitors files for changes and automatically rebuilds or reruns tests.
*   **`env`:** Sets up or displays the project's development environment.
*   **`docs`:**  Regenerates documentation from source code.
*   **`sync`:** Performs a Git rebase to synchronize the local branch with the remote.

### The following targets are preferred, but may ALSO have aliased versions that are specific to the project.
*   **`promote`:** Updates the build number for the next build.
*   **`new-module`:** Creates a new module or component within the project.  (Requires a well-defined directory structure).
*   **`run`:**  Executes the compiled program or application.
*   **`install`:**  Installs the project to a system directory.
*   **`uninstall`:** Removes the installed project from the system.
*   **`deploy`:** Deploys the project to a specified environment.  Should have variants for `dev` (default) and `prod`.  Example: `deploy-dev`, `deploy-prod`.

### The following are potential targets
*   **`mutation`:** Performs mutation testing.
*   **`performance`:** Performs performance testing.
*   **`security`:** Performs security checks.
*   **`docker`:** builds release into docker package. This may be the standard build or release procedure if there isn't a compile step.
*   **`docker-run`:** runs a `docker-compose` or `docker run` for the generated package.

**III.  Directory Structure and Script Location**

*   **Scripts Directory:** All executable scripts *must* reside in a central `/bin` directory or a well-defined subdirectory structure within it (e.g., `/bin/format`, `/bin/test`, `/bin/deploy`).  *Do not* create scripts anywhere else!
*   **Makefile Location:**  Place `Makefiles` in appropriate directories based on the project's module/component structure. This facilitates modular builds and testing.
*   **Copier Templates:** Keep your copier template (e.g., in `${REPO_ROOT}/ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/`) up-to-date with these new best practices.

**IV.  Makefile Best Practices & Style**

*   **`.PHONY` Targets:**  Declare all non-file targets (like `clean`, `help`) as `.PHONY`.
    ```makefile
    .PHONY: clean archive all help check format test lint run install uninstall coverage deploy release version status watch env docs sync new-module deploy-dev deploy-prod
    ```

*   **`.DEFAULT_GOAL`:** Set a default goal (usually `help` or `all`) so that running `make` without arguments performs a useful action. Whatever the default is, in the case of it being a default run of `make` with no arguments, it should follow calling `help` and explaining which target is being called subsequently.
    ```makefile
    .DEFAULT_GOAL := help
    ```

*   **Logical Grouping:** Organize targets into logical groups (e.g., build, testing, deployment) using comments and headers.

    ```makefile
    # ====================================================================
    # Build Targets
    # ====================================================================

    all: ...

    # ====================================================================
    # Testing Targets
    # ====================================================================

    test: ...
    lint: ...
    ```

*   **Explicit Rules:** Avoid relying on implicit rules unless you fully understand their behavior.  Be explicit about dependencies and commands.

*   **Variables:** Use variables to avoid repetition and make the `Makefile` easier to maintain.

    ```makefile
    PROJECT_NAME := my-awesome-project
    BIN_DIR      := /bin
    FORMAT_SCRIPT := $(BIN_DIR)/format

    format:
    	$(FORMAT_SCRIPT)
    ```

*   **Shell Functions (Judiciously):**  Define shell functions for more complex, reusable logic, but *still* prefer calling external scripts.

    ```makefile
    # Example (use sparingly - prefer scripts)
    define get_git_commit
    	$(shell git rev-parse HEAD)
    endef

    GIT_COMMIT := $(call get_git_commit)
    ```

*   **Modular Makefiles (using `include`):**  For large projects, break the `Makefile` into smaller, modular files and `include` them.  This improves organization and reduces complexity.

    ```makefile
    include modules/database.mk
    include modules/frontend.mk
    ```

*   **Error Handling:**  Add error handling to targets to ensure they fail gracefully.
    ```makefile
    validate:
    	@$(BIN_DIR)/validation-script || (echo "Validation failed!" && exit 1)
    ```

*   **Parallel Execution:**  Ensure targets are safe for parallel execution using `make -j`.  Declare dependencies correctly to avoid race conditions.

*   **Auto-Generated `help` Target:** Implement a `help` target that automatically extracts target descriptions from the `Makefile`.

    ```makefile
    help: ## Show this help message
    	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
    ```

    *   **Important:** Use `##` after the target definition to add the description.

    ```makefile
    clean: ## Remove generated files
    	$(BIN_DIR)/clean
    ```

*   **Informative Comments:**  Add comments to explain the *why* behind decisions, not just the *what*.

*   **Environment Detection:**  Create targets to check the environment and tool versions.  Be sure to include all tools called from the scripts in `/bin`. This helps ensure that the project can be built and run correctly.

    ```makefile
    env-check:
    	@echo "Checking Python version..."
    	@python3 --version
    	@echo "Checking required dependencies..."
    	@pip3 freeze | grep -q "requests" || (echo "Error: requests library not found. Please install it." && exit 1)
    ```

*   **Documentation Synchronization:**  Automate a check or a target to ensure that the `README.md` documentation matches the `Makefile` targets and includes a `mermaid` diagram that includes the dependency tree.

*   **Sentinal Files/Metadata:**  Use sentinel files or metadata files (e.g., `.ruleset`, `.windconf`) to encode configuration or dependencies for each component or directory.

**V.  Example Makefile Structure**

```makefile
# ====================================================================
# Project Configuration
# ====================================================================

PROJECT_NAME := my-amazing-application
BIN_DIR      := /bin
VERSION      := 1.2.3

# ====================================================================
# Phony Targets (Targets that don't create files)
# ====================================================================

.PHONY: clean archive all help check format test lint run install uninstall coverage deploy release version status watch env docs sync new-module deploy-dev deploy-prod

# ====================================================================
# Default Goal
# ====================================================================

.DEFAULT_GOAL := help

# ====================================================================
# Build Targets
# ====================================================================

all: ## Build the entire project
	$(BIN_DIR)/build

# ====================================================================
# Cleaning Targets
# ====================================================================

clean: ## Remove generated files
	$(BIN_DIR)/clean

archive: ## Create an archive of the project
	$(BIN_DIR)/archive

# ====================================================================
# Testing Targets
# ====================================================================

test: ## Run all unit tests
	$(BIN_DIR)/test

lint: ## Run all linting tools
	$(BIN_DIR)/lint

check: ## Run static analysis and code checks
	$(BIN_DIR)/check

coverage: ## Generate code coverage reports
	$(BIN_DIR)/coverage

# ====================================================================
# Formatting Targets
# ====================================================================

format: ## Format code according to standards
	$(BIN_DIR)/format

# ===
# Running and Installation Targets
# ===

run: ## Execute the application
	$(BIN_DIR)/run

install: ## Install the application
	$(BIN_DIR)/install

uninstall: ## Uninstall the application
	$(BIN_DIR)/uninstall

# ===
# Deployment Targets
# ===

deploy-dev: ## Deploy to the development environment
	$(BIN_DIR)/deploy dev

deploy-prod: ## Deploy to the production environment
	$(BIN_DIR)/deploy prod

deploy: deploy-dev ## Default deploy target is development

# ====================================================================
# Relea