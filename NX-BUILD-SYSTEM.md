# Nx Build System for levonk-ansible-galaxy

This document describes the Nx build system implementation for the levonk-ansible-galaxy project, which replaces the previous Makefile-based build system while preserving all functionality.

## Overview

The Nx build system provides a modern, efficient way to orchestrate the build, test, and publishing processes for Ansible Galaxy collections. It maintains the same principles as the previous Makefile system:

- **Centralized Scripting**: All executable logic remains in the `/bin` directory
- **Build System as Orchestrator**: Nx only handles dependencies and execution order
- **Standardized Targets**: Common set of targets across all projects
- **DRY Principle**: Maximizes code reuse
- **Graceful Failure**: Provides informative error messages

## Project Structure

The Nx configuration organizes the codebase into projects:

- **Collections**: Each collection is a separate project
- **Roles**: Each role is a separate project within its collection
- **Scripts**: The bin directory scripts remain the core of the build system

## Installation

To set up the Nx build system:

```bash
# Install dependencies
npm install
```

## Generate Project Configuration

Before using the Nx build system, you need to generate the project configuration:

```bash
# Generate Nx project configuration for all collections and roles
node tools/scripts/generate-nx-projects.js

# Generate script wrappers
node tools/scripts/generate-script-wrappers.js
```

## Usage

### Core Targets

| Command | Description |
|---------|-------------|
| `nx run-many --target=build --all` | Build all collections |
| `nx run-many --target=test --all` | Run tests for all collections |
| `nx run-many --target=lint --all` | Run all linters |
| `nx build [collection]` | Build specific collection |
| `nx test [collection]` | Test specific collection |
| `nx lint [collection]` | Lint specific collection |

### Publishing Targets

| Command | Description |
|---------|-------------|
| `nx run-many --target=publish-beta --all` | Publish all collections to beta |
| `nx run-many --target=publish-prod --all` | Publish all collections to production |
| `nx publish-beta [collection]` | Publish specific collection to beta |
| `nx publish-prod [collection]` | Publish specific collection to production |

### Version Management

| Command | Description |
|---------|-------------|
| `nx promote-build [collection]` | Increment build version |
| `nx promote-minor [collection]` | Increment minor version |
| `nx promote-major [collection]` | Increment major version |

### Installation Targets

| Command | Description |
|---------|-------------|
| `nx inst-src [collection]` | Install from source |
| `nx inst-repo [collection]` | Install from repository |
| `nx inst-build [collection]` | Install from build artifacts |
| `nx inst-beta [collection]` | Install from beta server |
| `nx inst-prod [collection]` | Install from production server |
| `nx uninstall [collection]` | Uninstall collection |

### Role-Specific Targets

| Command | Description |
|---------|-------------|
| `nx test [collection]-[role]` | Test specific role |
| `nx lint [collection]-[role]` | Lint specific role |
| `nx molecule [collection]-[role]` | Run molecule tests for role |

### Development Targets

| Command | Description |
|---------|-------------|
| `npm run new-collection -- --name=NAME` | Create a new collection |
| `npm run new-role -- --collection=COLL --name=NAME` | Create a new role |
| `npm run new-module -- --collection=COLL --name=NAME` | Create a new module |

### Help and Documentation

| Command | Description |
|---------|-------------|
| `npm run help` | Show available targets and help |
| `nx graph` | Visualize the project dependency graph |

## Environment Variables

The Nx build system uses the same environment variables as the Makefile system:

- `ANSIBLE_GALAXY_TOKEN`: Token for publishing to Galaxy
- `GALAXY_BETA_SERVER`: URL of the beta server
- `GALAXY_PROD_SERVER`: URL of the production server
- `VERSION`: Version string for collections
- `NAMESPACE`: Namespace for collections (default: levonk)

## Advantages of Nx

- **Caching**: Nx caches task results for faster builds
- **Dependency Graph**: Automatically manages dependencies between tasks
- **Parallel Execution**: Runs tasks in parallel when possible
- **Affected Commands**: Only runs tasks for projects affected by changes
- **Visualization**: Provides a visual graph of project dependencies

## Migration Notes

This Nx build system is designed to be a drop-in replacement for the previous Makefile system:

1. All existing scripts in the `bin` directory are used without modification
2. The same environment variables and configuration are maintained
3. All functionality from the Makefile system is preserved
4. The hierarchical structure of collections and roles is maintained

## Troubleshooting

If you encounter issues with the Nx build system:

1. Check that all required environment variables are set
2. Ensure the script wrappers have been generated
3. Verify that the project configuration has been generated
4. Check the Nx cache if tasks are not running as expected (`nx reset`)

## References

- [Nx Documentation](https://nx.dev/getting-started/intro)
- [Original Makefile Documentation](./README.md)
