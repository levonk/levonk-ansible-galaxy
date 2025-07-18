# Ansible Role: levonk.user_setup.chezmoi

This role installs and configures [chezmoi](https://chezmoi.io), a powerful tool for managing your dotfiles across multiple machines.

## Description

The role performs the following actions:

1. Checks for the presence of the required `chezmoi_repo` variable.
2. Installs `chezmoi` using the official installer script, which is vetted for security using the `levonk.common.roles.vet_script_installer` role.
3. Initializes `chezmoi` with the specified dotfiles repository.
4. Applies the dotfiles to the user's home directory.

The role is idempotent and will safely re-run, pulling the latest changes from your dotfiles repository and applying them.

## Requirements

- `git` must be installed on the target machine.
- The `levonk.common.roles.vet_script_installer` role is required as a dependency.

## Role Variables

The following variables are used by this role:

| Variable       | Required | Default | Description                                      |
|----------------|----------|---------|--------------------------------------------------|
| `chezmoi_repo` | Yes      | `null`  | The URL of the Git repository containing your dotfiles. |

## Dependencies

- `levonk.common.roles.vet_script_installer`

## Example Playbook

```yaml
---
- hosts: all
  vars:
    chezmoi_repo: "https://github.com/username/dotfiles.git"
  roles:
    - role: levonk.user_setup.chezmoi
```

## License

Copyright (c) 2025, Brillarc, LLC

## Author Information

This role was created in 2025 by Brillarc, LLC.
