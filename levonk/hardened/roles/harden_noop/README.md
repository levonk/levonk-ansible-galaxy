# harden_noop Role

No-op role for testing or compatibility scenarios. Does not apply any hardening.

## Features
- Used for validation, testing, or skipping hardening
- Ensures pipeline compatibility

## Usage
```yaml
- hosts: all
  roles:
    - role: harden_noop
```

## License
AGPL-3.0-only

## Author
levonk <v3l8dud3@lkara.com>
