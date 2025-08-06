# Makefiles Standardization - Success Criteria

## Quick Start

### First-Time Setup
```bash
# 1. Install dependencies
make check-tools

# 2. Start development environment
make dev-shell

# 3. Build and test
make all
```

### Common Commands
```bash
# List all available targets
make help

# Create new collection
./bin/setup-new20-collection.sh

# Run tests
make test

# Create beta release
make beta
```

## Project Context
- This is the `levonk-ansible-galaxy` repository, containing Ansible collections for system automation.
- Uses a containerized development environment with Makefile-based workflows.
- Follows a hierarchical structure with collections, roles, and modules.
- Uses `copier` for templating new collections/roles/modules.

## Repository Structure
```
/
├── ansible-galaxy/              # Main development directory
│   ├── collections/             # All collections
│   │   └── ansible_collections/
│   │       ├── blueprint-namespace/  # Template collections
│   │       └── levonk/          # Actual collections
│   ├── common.mk               # Shared variables
│   └── Makefile.targets        # Shared targets
└── bin/                        # All executable scripts
```

## Overview
This document outlines the requirements for standardizing Makefiles across the levonk-ansible-galaxy repository and tracks the progress of the standardization effort.

## Requirements

### 1. File Structure
- [ ] All Makefiles must be named `Makefile` (case-sensitive)
- [ ] Shared targets must be in `ansible-galaxy/Makefile.targets`
- [ ] Common variables must be in `ansible-galaxy/common.mk`
- [ ] Main entry point is `ansible-galaxy/Makefile`
- [ ] Makefiles must exist at every level of the repository hierarchy:
  - Repository root
  - ansible-galaxy/
  - Each collection directory
  - Each role directory
  - Template directories (blueprint-namespace)

### 2. Required Targets
All Makefiles must include or implement the following targets, either directly or through `Makefile.targets`. The targets are organized by workflow and include their dependencies where relevant.

#### Development Workflow
- [ ] `all` - Build and test all collections (default)
  - Depends on: `build`, `test`
- [ ] `build` - Build all collections
  - Depends on: Clean build environment
- [ ] `clean` - Remove build artifacts
- [ ] `lint` - Run all linters (includes all lint-* targets)
  - Depends on: `lint-ansible`, `lint-markdown`, `lint-yaml`, `lint-galaxy`
- [ ] `lint-ansible` - Lint Ansible content
- [ ] `lint-markdown` - Lint Markdown files
- [ ] `lint-yaml` - Lint YAML files
- [ ] `lint-galaxy` - Lint galaxy.yml files
- [ ] `test` - Run tests on all collections
  - Depends on: `test-build`
- [ ] `test-build` - Build and run tests in a container
  - Depends on: `build`
- [ ] `test-src` - Test installation from source
- [ ] `test-repo` - Test installation from repository
- [ ] `coverage-check` - Verify test coverage meets requirements
- [ ] `ee-clean` - Clean execution environment images

#### Beta Release Pipeline
- [ ] `beta` - Complete beta release workflow
  - Depends on: `beta-phase1-verify` → `beta-phase2-promote` → `beta-phase3-verify` → `beta-phase4-publish`
- [ ] `beta-phase1-verify` - Verify current version
  - Depends on: `ee-clean` → `env-check` → `ee-check` → `git-check-clean-publish` → `clean` → `build` → `lint` → `test-build` → `coverage-check`
- [ ] `beta-phase2-promote` - Promote version
  - Depends on: `promote`
- [ ] `beta-phase3-verify` - Verify new version
  - Depends on: `ee-clean` → `env-check` → `ee-check` → `git-check-clean-publish` → `clean` → `build` → `lint` → `test-build` → `coverage-check`
- [ ] `beta-phase4-publish` - Publish to beta
  - Depends on: `publish-beta` → `test-beta` → `git-tag-beta` → `inst-beta`
- [ ] `publish-beta` - Upload to beta server
- [ ] `test-beta` - Verify installation from beta server
- [ ] `git-tag-beta` - Create beta version tag
- [ ] `inst-beta` - Install from beta server

#### Production Release Pipeline
- [ ] `prod` - Complete production release workflow
  - Depends on: `prod-phase1-beta` → `prod-phase2-backup` → `prod-phase3-publish` → `prod-phase4-verify` → `prod-phase5-finalize`
- [ ] `prod-phase1-beta` - Verify beta complete
  - Depends on: `beta-phase4-publish`
- [ ] `prod-phase2-backup` - Backup production
  - Depends on: `backup-prod`
- [ ] `prod-phase3-publish` - Publish to production
  - Depends on: `publish-prod`
- [ ] `prod-phase4-verify` - Verify production
  - Depends on: `test-prod`
- [ ] `prod-phase5-finalize` - Finalize production
  - Depends on: `git-tag-prod` → `inst-prod`
- [ ] `backup-prod` - Backup current production state
- [ ] `publish-prod` - Promote to production server
- [ ] `test-prod` - Verify installation from production
- [ ] `git-tag-prod` - Create production version tag
- [ ] `rollback-prod` - Restore from production backup

#### Version Management
- [ ] `promote` - Alias for `promote-build`
- [ ] `promote-build` - Increment build version number
- [ ] `promote-minor` - Increment minor version number
- [ ] `promote-major` - Increment major version number

#### Installation Methods
- [ ] `inst-src` - Install from source
- [ ] `inst-repo` - Install from git repository
- [ ] `inst-build` - Install from local build
- [ ] `inst-beta` - Install from beta server
- [ ] `inst-prod` - Install from production server

#### Component Management
- [ ] `new-collection` - Create a new collection
- [ ] `new-role` - Create a new role in a collection
- [ ] `new-module` - Create a new module in a collection
- [ ] `git-check-clean-dev` - Check for clean git working directory (dev)
- [ ] `git-check-clean-publish` - Check for clean git working directory (publish)
- [ ] `git-commit` - Commit changes with standardized message

#### Execution Environment
- [ ] `ee-build` - Build the execution environment image
- [ ] `ee-lint` - Run linters in the execution environment
- [ ] `ee-shell` - Start a shell in the execution environment
- [ ] `ee-test` - Run tests in the execution environment
- [ ] `env-check` - Check environment for required tools
  - Depends on: `check-tools`, `check-linters`, `check-tests`
- [ ] `ee-check` - Check Docker environment
  - Depends on: `check-docker`

#### Environment Checks
- [ ] `check-git` - Verify git installation
- [ ] `check-python` - Verify Python installation
- [ ] `check-ansible` - Verify Ansible installation
  - Depends on: `check-python`
- [ ] `check-pyenv` - Verify pyenv installation
- [ ] `check-uv` - Verify uv installation
- [ ] `check-docker` - Verify Docker/Podman installation
- [ ] `check-make` - Verify make installation
- [ ] `check-ansible-lint` - Verify ansible-lint
- [ ] `check-yamllint` - Verify yamllint
- [ ] `check-markdownlint` - Verify markdownlint
- [ ] `check-flake8` - Verify flake8
- [ ] `check-pytest` - Verify pytest
- [ ] `check-tox` - Verify tox
- [ ] `check-molecule` - Verify molecule
  - Depends on: `check-python`, `check-docker`
- [ ] `check-linters` - Verify all linting tools
  - Depends on: `check-ansible-lint`, `check-yamllint`, `check-markdownlint`, `check-flake8`
- [ ] `check-tests` - Verify testing tools
  - Depends on: `check-pytest`, `check-tox`, `check-molecule`
- [ ] `check-tools` - Verify required tools
  - Depends on: `check-git`, `check-python`, `check-ansible`, `check-pyenv`, `check-uv`, `check-docker`, `check-make`


### 3. Standard Variables
- [ ] `PROJECT_NAME` - Name of the project/component
- [ ] `VERSION` - Version of the component
- [ ] `BIN_DIR` - Directory for executable scripts
- [ ] `DIST_DIR` - Directory for build outputs

### 4. Documentation
- [ ] Each target must have a comment describing its purpose
- [ ] The `help` target must list all available targets
- [ ] Dependencies between targets must be clearly documented

### 5. Best Practices
- [ ] Use `.PHONY` for non-file targets
- [ ] Include error handling
- [ ] Support parallel execution where possible
- [ ] Use variables for paths and commands
- [ ] Follow consistent indentation (tabs for recipes, spaces for alignment)

## Makefile Checklist

A comprehensive checklist of all Makefiles in the project is maintained in a separate file for better organization and maintainability:

📋 [Makefile Standardization Checklist](20250804-makefiles-success-checklist.md)

This checklist includes all Makefiles across the project, including:
- Root level Makefiles
- Collection level Makefiles
- Role level Makefiles
- Test directories
- Molecule test configurations
- Documentation Makefiles
- Verification scripts

### Root Level
- [ ] `/Makefile`

### Ansible Galaxy
- [ ] `ansible-galaxy/Makefile`
- [ ] `ansible-galaxy/Makefile.targets`
- [ ] `ansible-galaxy/common.mk`
- [ ] `ansible-galaxy/collections/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/Makefile`


## Implementation Priorities

### 1. Critical Path (Complete First)
- [x] Update `ansible-galaxy/Makefile.targets` with core workflows
- [ ] Update `copier` templates in `blueprint-namespace/`
- [ ] Standardize `copier` collection/roles/modules/test-level Makefiles in `blueprint-namespace/`
- [ ] Standardize all Makefiles everywhere else as per above.
- [ ] Implement test infrastructure

### 2. Templates (For New Components)
- [ ] Document template variables
- [ ] Add validation scripts

### 3. Verification
- [ ] Create test plan for each target
- [ ] Document manual verification steps
- [ ] Add CI/CD integration

## Development Workflow

### Setup
```bash
# 1. Start development container
make dev-shell

# 2. Sync dependencies
make sync
```

### Common Tasks
```bash
# Create new collection (from repo root)
./bin/setup-new20-collection.sh

# Run tests for a specific collection
cd ansible-galaxy/collections/ansible_collections/levonk/COLLECTION
make test

# Publish beta release
make beta
```

## Troubleshooting

### Common Issues
1. **Missing Dependencies**
   - Symptom: `command not found` errors
   - Fix: Run `make check-tools` and install missing tools

2. **Permission Issues**
   - Symptom: Permission denied when running scripts
   - Fix: Ensure scripts in `bin/` are executable:
     ```bash
     chmod +x bin/*
     ```

### Debugging
- Add `DEBUG=1` to see commands:
  ```bash
  DEBUG=1 make build
  ```
- Check container logs:
  ```bash
  docker-compose logs -f
  ```

## Maintenance

### Adding New Targets
1. Add to appropriate section in `Makefile.targets`
2. Document in README.md
3. Update help text
4. Add tests

### Version Upgrades
- Update version in `common.mk`
- Test with:
  ```bash
  make clean test VERSION=new-version
  ```

### Copier Template Updates
```bash
# After updating templates, test generation:
copier copy ansible-galaxy/collections/ansible_collections/blueprint-namespace /tmp/test-collection
```

## Related Documents
- [Development Guide](link-to-dev-guide)
- [Release Process](link-to-release-docs)
- [Copier Templates](link-to-copier-docs)

## Notes
- Checkboxes should be marked as complete when a Makefile meets all requirements
- Use `[x]` for completed items, `[ ]` for incomplete items
- Add notes for any special considerations or exceptions
