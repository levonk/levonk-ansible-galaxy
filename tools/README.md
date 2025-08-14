# Development Tools

This directory contains development and build tooling for the project, including custom Nx executors, utility scripts, and templates.

## Directory Structure

### Executors (`/executors/`)
Custom Nx executors that extend the build system's capabilities:
- `shell/`: Executor for running shell commands and scripts
  - `executor.json`: Executor configuration
  - `impl.mjs`: ESM implementation
  - `impl.cjs`: CommonJS wrapper for compatibility
  - `schema.json`: Input validation schema

### Scripts (`/scripts/`)
Node.js scripts for project maintenance and automation:
- `generate-nx-projects.js`: Generates Nx project configurations
- `new-collection.js`: Scaffolds new Ansible collections
- `new-role.js`: Creates new role structures
- `update-readme.js`: Updates project documentation
- `verify-nx-setup.js`: Validates Nx workspace configuration
- `makefile-nx-bridge.js`: Bridges Makefile and Nx commands

### Templates (`/templates/`)
JSON templates used by the generator scripts:
- `collection-project.json`: Template for new collections
- `role-project.json`: Template for new roles

## Usage

### Running Scripts
```bash
# Run a script directly with node
node tools/scripts/script-name.js

# Or use the Makefile targets
make generate  # Runs all generators
make new-collection name=my-collection  # Create a new collection
make new-role collection=my-collection name=my-role  # Create a new role
```

### Adding New Executors
1. Create a new directory under `tools/executors/`
2. Add `executor.json`, implementation files, and schema
3. Reference the executor in your project's `project.json`

## Development

- **Node.js**: Required for running the scripts
- **Nx**: Used for task orchestration
- **ESLint**: Code quality and style enforcement

Run `npm run lint` to check code quality before committing changes.
