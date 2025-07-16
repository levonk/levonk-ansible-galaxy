# base_system Role

This role provides core OS configuration, package management, and basic networking setup for new hosts. It is the foundation for all other roles in the personal-bootstrap collection.

## Features
- Installs essential system packages
- Configures basic networking
- Prepares host for further configuration (hardening, dev environments, etc.)

## Usage
```yaml
- hosts: all
  roles:
    - role: base_system
```

## Requirements
- Ansible 2.9+
- Supported OS: Linux (Debian/Ubuntu, RHEL/CentOS, etc.)

## Variables
See `vars/main.yml` for configurable options.

## License
AGPL-3.0-only

## Author
levonk
