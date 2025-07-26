# levonk.common Collection

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common)

A set of cross-platform Ansible roles for secure package and script management, font installation, GUI enablement, firewall management, and more. Designed for clarity, maintainability, and security best practices.

---

## Overview

This Ansible collection provides reusable roles for system configuration, secure automation, compliance, and best-practices infrastructure management. All content is designed for maintainability, clarity, and ease of contribution.

---

## Features & Included Content

### Roles

| Name                    | Description                                  | Major Features/Tasks                                              | Docs |
|-------------------------|----------------------------------------------|-------------------------------------------------------------------|------|
| checksums               | Checksum validation for files/scripts        | Download, validate, log checksums                                 | [README](roles/checksums/README.md) |
| fonts                   | Cross-platform font installation             | JetBrains Mono Nerd Font, OS-specific, fallback manual install    | [README](roles/fonts/README.md) |
| install_gui_conditionally | Conditional GUI install                    | OS-specific GUI enablement, `graphical` tag                       | [README](roles/install_gui_conditionally/README.md) |
| open_firewall_port      | Open firewall ports cross-platform           | UFW, firewalld, pf, Windows Defender                              | [README](roles/open_firewall_port/README.md) |
| package                 | Secure, idempotent package management        | Unified manager, caching, checksum, cross-platform                | [README](roles/package/README.md) |
| vet_script_installer    | Secure script download/vetting/execution     | Checksum, vet tool, audit log, fail-fast                          | [README](roles/vet_script_installer/README.md) |

---

## Usage

### Example: Using Multiple Roles

```yaml
- hosts: all
  collections:
    - levonk.common
  roles:
    - package
    - open_firewall_port
    - fonts
    - vet_script_installer
  vars:
    open_firewall_port_port: 8080
    fonts_install: true
    vet_script_url: "https://example.com/install.sh"
    vet_script_dest: "/tmp/install.sh"
```

### Advanced Usage Patterns
- Use tags to selectively enable features (see role READMEs for tag docs)
- Override variables at play, host, or group level for flexible configuration
- Reference [role READMEs](roles/) for full variable tables, activation enums, and advanced examples

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
