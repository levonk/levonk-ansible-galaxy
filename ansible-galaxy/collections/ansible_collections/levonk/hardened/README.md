# levonk.hardened Collection

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened)

A comprehensive collection of security hardening roles for Linux, Windows, and macOS. Provides baseline, moderate, paranoid, and custom hardening, Bitwarden CLI automation, and a no-op role for pipelines. Designed for clarity, compliance, and maintainability.

---

## Overview

This Ansible collection provides reusable roles for system hardening, compliance, and secure automation. Each role follows best-practices documentation and variable conventions for easy adoption and contribution.

---

## Features & Included Content

### Roles

| Name                         | Description                                        | Major Features/Tasks                                                                 | Docs |
|------------------------------|----------------------------------------------------|--------------------------------------------------------------------------------------|------|
| bitwarden-cli-support        | Install/manage Bitwarden CLI tools (`bw`, `bws`, `rbw`) | Secure, idempotent CLI install, OS-specific logic, compliance notes                  | [README](roles/bitwarden-cli-support/README.md) |
| harden_baseline              | Minimal baseline security hardening                | Linux/Windows/macOS baseline, GPG, firewall, secure scripting, Cloudflare WARP VPN   | [README](roles/harden_baseline/README.md) |
| harden_custom                | Template for custom/user-defined hardening         | Imports baseline/moderate/paranoid, supports custom controls, full activation enums   | [README](roles/harden_custom/README.md) |
| harden_moderate              | Moderate security hardening                        | Baseline + advanced firewall, password, audit, extra OS-specific controls            | [README](roles/harden_moderate/README.md) |
| harden_noop                  | No-op hardening role for pipelines/testing         | Emits debug message, no system changes                                               | [README](roles/harden_noop/README.md) |
| harden_paranoid              | Strictest/paranoid security hardening              | Baseline + strictest controls, compliance, high-security environments                | [README](roles/harden_paranoid/README.md) |

### Modules

| Name         | Description           | Key Parameters | Docs |
|--------------|----------------------|----------------|------|
| *(none yet)* |                      |                |      |

---

## Usage

### Dependencies
- See individual role READMEs for OS/package dependencies

---

### Example: Using Multiple Roles

```yaml
- hosts: all
  collections:
    - levonk.hardened
  roles:
    - harden_baseline
    - harden_moderate
    - harden_paranoid
    - bitwarden-cli-support
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

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update documentation for any new features, roles, or modules. See individual role READMEs for detailed contribution guidelines.

---

## License
Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.

## Author Information
levonk

*Document generated on: 2025-07-25*  
*Version: 1.0.0*

Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
