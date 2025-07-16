# harden_baseline Role

Provides minimal baseline security hardening for cross-platform hosts (Linux, macOS, Windows).

## Features
- Essential OS security settings
- Prepares for further hardening
- Idempotent and safe for general use

## Usage
```yaml
- hosts: all
  roles:
    - role: harden_baseline
```

## License
AGPL-3.0-only

## Author
levonk <v3l8dud3@lkara.com>
