# Ansible Galaxy Directory

This directory contains the main Ansible Galaxy collections and related configurations for the project.

## Structure

- `collections/`: Contains all Ansible collections
  - `ansible_collections/`: Standard Ansible collections directory
    - `levonk/`: Our collection namespace
      - `vibeops/`: Main collection containing roles and modules
      - `server_llmchat/`: Collection for LLM chat server components
- `dist/`: Built collection artifacts (`.tar.gz` files)
- `inventory/`: Inventory files for different environments
- `.markers/`: Build marker files for tracking build state

## Usage

- Build collections: `bun run build`
- Test collections: `bun run test`
- Lint collections: `bun run lint`

## Documentation

See the main [README.md](../README.md) for more information about the project structure and usage.
