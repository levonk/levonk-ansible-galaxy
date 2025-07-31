---
description: How to update Makefile documentation
---

# Updating Makefile Documentation

This workflow describes how to update the Makefile documentation across the Ansible Galaxy collections repository.

## Steps

1. Make changes to the Makefile(s) as needed, ensuring all targets have proper documentation comments using the `##` format
   ```makefile
   target-name: ## Description of what the target does
   ```

2. Generate documentation for a collection-level Makefile
   ```bash
   ./bin/generate-makefile-docs.sh ansible-galaxy/collections/ansible_collections/namespace/collection/Makefile /tmp/collection-makefile-docs.md
   ```

3. Generate documentation for a role-level Makefile
   ```bash
   ./bin/generate-makefile-docs.sh ansible-galaxy/collections/ansible_collections/namespace/collection/roles/role/Makefile /tmp/role-makefile-docs.md
   ```

4. Generate documentation for a namespace-level Makefile
   ```bash
   ./bin/generate-makefile-docs.sh ansible-galaxy/collections/ansible_collections/namespace/Makefile /tmp/namespace-makefile-docs.md
   ```

5. Update the README.md files with the generated documentation
   ```bash
   # For collection-level README.md
   sed -i '/^## Makefile/,/^## /d' ansible-galaxy/collections/ansible_collections/namespace/collection/README.md
   sed -i '/^# Makefile/r /tmp/collection-makefile-docs.md' ansible-galaxy/collections/ansible_collections/namespace/collection/README.md
   
   # For role-level README.md
   sed -i '/^## Makefile/,/^## /d' ansible-galaxy/collections/ansible_collections/namespace/collection/roles/role/README.md
   sed -i '/^# Makefile/r /tmp/role-makefile-docs.md' ansible-galaxy/collections/ansible_collections/namespace/collection/roles/role/README.md
   
   # For namespace-level README.md
   sed -i '/^## Makefile/,/^## /d' ansible-galaxy/collections/ansible_collections/namespace/README.md
   sed -i '/^# Makefile/r /tmp/namespace-makefile-docs.md' ansible-galaxy/collections/ansible_collections/namespace/README.md
   ```

6. If the README.md file doesn't exist or doesn't have a Makefile section, create it or add the section manually

7. Commit the changes to version control
   ```bash
   git add ansible-galaxy/collections/ansible_collections/namespace/collection/README.md
   git add ansible-galaxy/collections/ansible_collections/namespace/collection/roles/role/README.md
   git add ansible-galaxy/collections/ansible_collections/namespace/README.md
   git commit -m "Update Makefile documentation"
   ```

## Notes

- The documentation generator script creates a hierarchical list of targets grouped by category (Build & Test, Lint, Installation, Documentation, Utility)
- It also generates a mermaid diagram showing the dependencies between targets
- The script extracts target descriptions from the `##` comments in the Makefile
- Make sure all targets have proper documentation comments to be included in the generated documentation
