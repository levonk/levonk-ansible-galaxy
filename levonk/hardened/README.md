# levonk.hardened Collection

This Ansible Galaxy collection provides security hardening roles for cross-platform hosts (Linux, macOS, Windows), supporting compliance levels such as CIS and NIST. It enables stackable hardening profiles and secure-by-default configurations.

## Included Roles (to be implemented)
| Role             | Description                               |
|------------------|-------------------------------------------|
| harden_baseline  | Minimal baseline hardening                |
| harden_moderate  | Moderate hardening (recommended)          |
| harden_paranoid  | Maximum hardening, strict compliance      |
| harden_custom    | User-defined or organization-specific mix  |
| harden_noop      | No-op (for testing/compatibility)         |

## Installation
```bash
ansible-galaxy collection install levonk.hardened
```

## Usage Example
```yaml
- hosts: all
  collections:
    - levonk.hardened
  roles:
    - role: harden_baseline
    - role: harden_moderate
```

## Requirements
- Ansible 2.9+
- Supported OS: Linux (Debian/Ubuntu), macOS, Windows

## License
AGPL-3.0-only

## Author
levonk <v3l8dud3@lkara.com>
