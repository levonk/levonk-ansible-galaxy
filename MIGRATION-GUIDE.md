# Migrating from Makefile to Nx Build System

This guide provides instructions for migrating from the Makefile-based build system to the new Nx build system for the levonk-ansible-galaxy project.

## Migration Overview

The Nx build system is designed to be a drop-in replacement for the Makefile system, preserving all functionality while adding benefits like caching, dependency management, and parallel execution. The migration process is designed to be gradual, allowing both systems to coexist during the transition period.

## Makefile to Nx Command Mapping

| Makefile Command | Nx Command | Description |
|------------------|------------|-------------|
| `make build` | `npm run build` or `nx run-many --target=build --all` | Build all collections |
| `make build COLLECTION=common` | `nx build common` | Build specific collection |
| `make test` | `npm run test` or `nx run-many --target=test --all` | Test all collections |
| `make test COLLECTION=common` | `nx test common` | Test specific collection |
| `make test-role COLLECTION=common ROLE=example` | `nx test common-example` | Test specific role |
| `make lint` | `npm run lint` or `nx run-many --target=lint --all` | Lint all collections |
| `make lint COLLECTION=common` | `nx lint common` | Lint specific collection |
| `make lint-role COLLECTION=common ROLE=example` | `nx lint common-example` | Lint specific role |
| `make publish-beta` | `npm run publish-beta` | Publish all collections to beta |
| `make publish-beta COLLECTION=common` | `nx publish-beta common` | Publish specific collection to beta |
| `make publish-prod` | `npm run publish-prod` | Publish all collections to production |
| `make publish-prod COLLECTION=common` | `nx publish-prod common` | Publish specific collection to production |
| `make promote-build` | `npm run promote-build` | Increment build version for all collections |
| `make promote-build COLLECTION=common` | `nx promote-build common` | Increment build version for specific collection |
| `make promote-minor` | `npm run promote-minor` | Increment minor version for all collections |
| `make promote-minor COLLECTION=common` | `nx promote-minor common` | Increment minor version for specific collection |
| `make promote-major` | `npm run promote-major` | Increment major version for all collections |
| `make promote-major COLLECTION=common` | `nx promote-major common` | Increment major version for specific collection |
| `make inst-src` | `npm run inst-src` | Install all collections from source |
| `make inst-src COLLECTION=common` | `nx inst-src common` | Install specific collection from source |
| `make inst-repo` | `npm run inst-repo` | Install all collections from repository |
| `make inst-repo COLLECTION=common` | `nx inst-repo common` | Install specific collection from repository |
| `make inst-build` | `npm run inst-build` | Install all collections from build artifacts |
| `make inst-build COLLECTION=common` | `nx inst-build common` | Install specific collection from build artifacts |
| `make inst-beta` | `npm run inst-beta` | Install all collections from beta server |
| `make inst-beta COLLECTION=common` | `nx inst-beta common` | Install specific collection from beta server |
| `make inst-prod` | `npm run inst-prod` | Install all collections from production server |
| `make inst-prod COLLECTION=common` | `nx inst-prod common` | Install specific collection from production server |
| `make uninstall` | `npm run uninstall` | Uninstall all collections |
| `make uninstall COLLECTION=common` | `nx uninstall common` | Uninstall specific collection |
| `make new-collection NAME=example` | `npm run new-collection -- --name=example` | Create a new collection |
| `make new-role COLLECTION=common NAME=example` | `npm run new-role -- --collection=common --name=example` | Create a new role |
| `make new-module COLLECTION=common NAME=example` | `npm run new-module -- --collection=common --name=example` | Create a new module |
| `make help` | `npm run help` | Show help |
| `make check-env` | `nx check-env` | Check environment variables |
| `make check-tools` | `nx check-tools` | Check required tools |
| `make clean` | `nx clean` | Clean build artifacts |
| `make debug` | `nx debug` | Show debug information |
| `make docs` | `nx docs` | Generate documentation |
| `make lint-yaml` | `nx lint-yaml` | Lint YAML files |
| `make lint-markdown` | `nx lint-markdown` | Lint Markdown files |
| `make lint-ansible` | `nx lint-ansible` | Lint Ansible files |
| `make lint-make` | `nx lint-make` | Lint Makefiles |
| `make version` | `nx version` | Show version |
| `make status` | `nx status` | Show status |
| `make sync` | `nx sync` | Sync with repository |
| `make shell` | `nx shell` | Open shell in container |

## Migration Steps

Follow these steps to migrate from the Makefile system to the Nx build system:

### 1. Install Dependencies

```bash
npm install
```

### 2. Generate Project Configuration

```bash
# Generate Nx project configuration for all collections and roles
npm run generate-projects

# Generate script wrappers
npm run generate-wrappers
```

### 3. Test the Nx Build System

```bash
# Run a simple build to verify the Nx system works
nx build common

# Run tests to verify the Nx system works
nx test common
```

### 4. Migrate Your Workflows

Update your workflows to use the Nx commands instead of Makefile commands. For example:

```bash
# Before
make build COLLECTION=common
make test COLLECTION=common
make publish-beta COLLECTION=common

# After
nx build common
nx test common
nx publish-beta common
```

### 5. Update CI/CD Pipelines

If you have CI/CD pipelines that use the Makefile system, update them to use the Nx commands. For example:

```yaml
# Before
script:
  - make build
  - make test
  - make publish-beta

# After
script:
  - npm run build
  - npm run test
  - npm run publish-beta
```

## Environment Variables

The Nx build system uses the same environment variables as the Makefile system:

- `ANSIBLE_GALAXY_TOKEN`: Token for publishing to Galaxy
- `GALAXY_BETA_SERVER`: URL of the beta server
- `GALAXY_PROD_SERVER`: URL of the production server
- `VERSION`: Version string for collections
- `NAMESPACE`: Namespace for collections (default: levonk)

## Benefits of the Nx Build System

- **Caching**: Nx caches task results for faster builds
- **Dependency Graph**: Automatically manages dependencies between tasks
- **Parallel Execution**: Runs tasks in parallel when possible
- **Affected Commands**: Only runs tasks for projects affected by changes
- **Visualization**: Provides a visual graph of project dependencies

## Troubleshooting

If you encounter issues with the Nx build system:

1. Check that all required environment variables are set
2. Ensure the script wrappers have been generated
3. Verify that the project configuration has been generated
4. Check the Nx cache if tasks are not running as expected (`nx reset`)
5. Compare the output of the Makefile and Nx commands to identify differences

## Rollback Plan

If you need to rollback to the Makefile system, you can continue to use the Makefiles as before. The Nx build system is designed to coexist with the Makefile system, so you can use either system depending on your needs.

## References

- [Nx Documentation](https://nx.dev/getting-started/intro)
- [Nx Build System Documentation](./NX-BUILD-SYSTEM.md)
- [Original Makefile Documentation](./README.md)
