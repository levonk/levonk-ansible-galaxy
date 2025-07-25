# levonk.user_setup Collection

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup)

A collection of roles for standardized, secure, and cross-platform user and shell setup on Linux, macOS, and Windows systems. Designed for clarity, maintainability, and best-practices onboarding.

---

## Overview

This Ansible collection provides reusable roles for user management, shell configuration, and advanced terminal environments. It is designed for maintainability, clarity, and ease of contribution.

---

## Features & Included Content

### Roles

| Name           | Description                                        | Major Features/Tasks                                                 | Docs |
|----------------|----------------------------------------------------|---------------------------------------------------------------------|------|
| chezmoi        | Dotfiles management with chezmoi                   | Pre-flight checks, install chezmoi, initialize/apply dotfiles        | [README](roles/chezmoi/README.md) |
| local_user     | Local user account management                      | Shell install, user create/update, SSH key management                | [README](roles/local_user/README.md) |
| remote_user    | Remote-access user (SSH/RDP) management            | Shell install, user create/update, SSH keys, enable RDP (Windows)    | [README](roles/remote_user/README.md) |
| service_user   | Service/system user creation with minimal privileges| Shell install, system user create/update                             | [README](roles/service_user/README.md) |
| thick-shell    | Advanced shell and terminal environment setup       | Multi-shell stack, tmux/zellij/mosh, fzf, direnv, neovim, CLI tools  | [README](roles/thick-shell/README.md) |

### Modules

| Name         | Description                      | Key Parameters                      | Docs |
|--------------|----------------------------------|-------------------------------------|------|
| *(none)*     |                                  |                                     |      |

---

## Usage

### Dependencies
- See individual role READMEs for role-specific dependencies.

---

### Example: Using Multiple Roles

```yaml
- hosts: all
  collections:
    - levonk.user_setup
  roles:
    - chezmoi
    - local_user
    - remote_user
    - service_user
    - thick-shell
  vars:
    chezmoi_repo: "https://github.com/username/dotfiles.git"
    local_user_name: "myuser"
    remote_user_name: "remoteuser"
    service_user_name: "svcuser"
    thick_shells:
      - zsh
      - bash
      - fish
```

### Advanced Usage Patterns
- Use tags to selectively enable features (see role READMEs for tag docs)
- Override variables at play, host, or group level for flexible configuration
- Reference [role READMEs](roles/) for full variable tables, activation enums, and advanced examples

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Linux, macOS, Windows (see individual roles for details)
- Additional requirements may apply per role

---

## Testing

- Molecule scenarios: see `roles/<role>/molecule/`
- ansible-test: `ansible-test integration`
- Linting: `ansible-lint`

```bash
# Install test requirements
pip install -r requirements-test.txt

# Run tests
ansible-test integration
```

---

## Best Practices for Collection Maintenance
- **Document every variable and parameter** in included roles using tables with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- **Link to the source** of each feature/task and variable usage for transparency and maintainability.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Reference external specs or requirements** where relevant.
- **Keep this README and all role/module docs up to date** as the collection evolves.
- **Encourage contributors** to follow these conventions for all new roles, modules, and features.

---

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update documentation for any new features, roles, or modules. See individual role READMEs for detailed contribution guidelines.

---

## License

Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.

*Document generated on: 2025-07-25*  
*Version: 1.0.0*
