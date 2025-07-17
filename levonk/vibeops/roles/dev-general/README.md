# Ansible Role: dev-general

This role provisions general-purpose development tools that are not specific to any single language or framework.

## Features

- **Super-Linter:** Pulls the latest `github/super-linter` Docker image. This provides a single, powerful linter that supports a wide variety of languages and formats, helping to enforce code quality and consistency across your projects.

## Usage Example

To use this role, simply include it in your playbook:

```yaml
- hosts: all
  roles:
    - role: levonk.vibeops.dev-general
```

## Requirements

- **Docker:** The Docker daemon must be installed and running on the target host. This role does not install Docker itself; it is recommended to use the `levonk.vibeops.dev-docker` role to manage the Docker installation.
- The `community.docker` Ansible collection must be installed.

## License

AGPL-3.0-only

## Author

levonk
