# harden_paranoid Role

Provides maximum security hardening for highly sensitive or regulated environments (Linux, macOS, Windows).

## Features
- Strict compliance settings (CIS/NIST)
- Disables non-essential services
- Suitable for high-risk or compliance-mandated systems

## Usage
```yaml
- hosts: all
  roles:
    - role: harden_paranoid
```

## License
AGPL-3.0-only

## Author
levonk <v3l8dud3@lkara.com>
