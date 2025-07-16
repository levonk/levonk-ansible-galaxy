# harden_custom Role

Allows user-defined or organization-specific security hardening for cross-platform hosts (Linux, macOS, Windows).

## Features
- Customizable hardening logic
- Supports overrides and organization policies
- Stackable with other hardening roles

## Usage
```yaml
- hosts: all
  roles:
    - role: harden_custom
```

## License
AGPL-3.0-only

## Author
levonk <v3l8dud3@lkara.com>
