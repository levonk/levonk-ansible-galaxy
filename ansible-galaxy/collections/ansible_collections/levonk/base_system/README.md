# levonk.base_system Ansible Collection

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/base_system)

A cross-platform collection of roles for foundational system setup, user management, system integrity, and safe reboots. Designed for clarity, security, and maintainability.

---

## Features & Included Roles

| Role           | Description                                      | Major Features/Tasks                                             | Docs |
|----------------|--------------------------------------------------|------------------------------------------------------------------|------|
| base_system    | Core system configuration and package management | Hostname, timezone/NTP, packages, fonts, shell, registry backup, package managers (APT/YUM/Homebrew/Chocolatey/WinGet), graphical subsystem | [README](roles/base_system/README.md) |
| user_setup     | User account, SSH/GPG key, dotfiles bootstrap    | User creation, SSH/GPG keygen, chezmoi dotfiles (opt-in)         | [README](roles/user_setup/README.md) |
| syscheck       | System integrity checks (async, cross-platform)  | Windows SFC, macOS diskutil, Linux fsck scheduling, reboot flag  | [README](roles/syscheck/README.md) |
| reboot_manager | Decoupled, safe system reboots                   | Reboot if `reboot_required` set by other roles                   | [README](roles/reboot_manager/README.md) |

---

## Usage

### Example: Using Multiple Roles

```yaml
- hosts: all
  become: true
  roles:
    - role: levonk.base_system.base_system
      vars:
        system_hostname: myhost123
        timezone: "America/Los_Angeles"
        ntp_servers:
          - "time.google.com"
          - "time.cloudflare.com"
        base_system_packages:
          - vim
          - curl
          - wget
          - git
    - role: levonk.base_system.user_setup
      vars:
        username: "alice"
        user_use_chezmoi: true
        chezmoi_repo_url: "git@github.com:alice/dotfiles.git"
    - role: levonk.base_system.syscheck
    - role: levonk.base_system.reboot_manager
```

---

## Requirements

- Ansible 2.9+
- Python 3.6+
- Supported platforms: Linux, macOS, Windows (see individual roles for details)
- Additional requirements may apply per role/module

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

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.


{{ collection_description }}

## Installation

```bash
ansible-galaxy collection install {{ collection_namespace }}.base_system
```

## Requirements

- Ansible {{ min_ansible_version | default('2.9+') }}
- Python {{ min_python_version | default('3.6+') }}
- Additional requirements...

## Included Content

### Roles

| Name | Description |
|------|-------------|
| `role_name` | Brief description of the role |

### Modules

| Name | Description |
|------|-------------|
| `module_name` | Brief description of the module |

## Usage

### Using a role

```yaml
- name: Include base_system role
  hosts: localhost
  collections:
    - {{ collection_namespace }}.base_system
  roles:
    - role_name
```

### Using a module

```yaml
- name: Use base_system module
  {{ collection_namespace }}.base_system.module_name:
    parameter: value
```

## Testing

```bash
# Install test requirements
pip install -r requirements-test.txt

# Run tests
ansible-test integration
```

## License

{{ license | default('AGPL-3.0') }}

## Author Information

{{ author | default('levonk') }}

*Document generated on: {{ "now" | strftime("%Y-%m-%d") }}*  
*Version: {{ collection_version | default('1.0.0') }}*

Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
