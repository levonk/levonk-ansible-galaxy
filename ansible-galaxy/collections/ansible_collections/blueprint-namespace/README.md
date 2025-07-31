# Blueprint Namespace

This namespace contains Ansible Galaxy collections following the best practices and standards for the levonk-ansible-galaxy project.

## Collections

| Collection | Description |
|------------|-------------|
| [blueprint-collection](blueprint-collection/README.md) | Template collection with example roles and modules |

# Makefile Documentation

This project uses a Makefile to automate common development tasks. The targets are organized hierarchically below.

## Target Hierarchy

### Build & Test Targets

- `all`: Build all collections in this namespace (alias for build)
- `archive`: Create archives of all collections
- `build`: Build all collections in this namespace
- `clean`: Remove generated files from all collections
- `format`: Format code according to standards in all collections
- `test`: Run tests for all collections in this namespace

### Lint Targets

- `lint-ansible`: Run ansible-lint on all collections
- `lint`: Run all linting tools on all collections
- `lint-markdown`: Run markdownlint on all collections
- `lint-yaml`: Run yamllint on all collections

### Installation Targets

- `install-beta`: Install all collections from beta server
- `install-build`: Install all collections from build artifacts
- `install`: Install all collections (alias for install-src)
- `install-prod`: Install all collections from production server
- `install-repo`: Install all collections from git repository
- `install-src`: Install all collections from source

### Documentation Targets

- `docs`: Generate documentation for all collections
- `help`: Show this help message
- `usage`: Show help message (alias for help)

### Utility Targets

- `status`: Show status of all collections
- `version`: Display versions of all collections

## Target Dependencies

The following diagram shows the dependencies between Makefile targets:

```mermaid
graph TD
all->build
archive->build
build->help
install-build->build
install->install-src
lint->lint-ansible
lint->lint-markdown
lint->lint-yaml
test->lint
usage->help
```

## Using the Makefile

To use the Makefile, run `make <target>` where `<target>` is one of the targets listed above.

For example:

```bash
# Show help
make help

# Build the project
make build

# Run all linting tools
make lint

# Run a specific linting tool
make lint-ansible
```

Running `make` without a target will show the help message and then build the project.

## Development Standards

For more information on the development standards and best practices for this namespace, see the [Makefile Standards and Best Practices](../../../../docs/standards/makefile-standards.md) document.
