# Ansible Role: dev-ansible

This role sets up a complete Ansible development environment on a target host.

## Features

- Installs `ansible-core` to provide the base Ansible engine.
- Installs essential development and testing tools via pip:
  - `molecule` with the Docker plugin: For robust, multi-scenario testing of Ansible roles using Docker containers.
  - `ansible-lint`: For enforcing best practices and catching common errors in Ansible content.
  - `yamllint`: For linting YAML files to ensure syntax and style consistency.
- Provides cross-platform support for Linux, macOS, and Windows (via Chocolatey).

## Usage Example

To use this role, simply include it in your playbook:

```yaml
- hosts: all
  roles:
    - role: levonk.vibeops.dev-ansible
```

## Variables

- `ansible_version`: Specify a version of Ansible to install (e.g., '6.7.0'). Defaults to 'latest'.
- `dev_ansible_tools`: A list of Python packages to install for the development environment. Defaults to `['molecule', 'molecule-plugins[docker]', 'ansible-lint', 'yamllint']`.

## Requirements

- A Python environment managed by the `dev-python` role.
- `Chocolatey` must be installed on Windows hosts for the Ansible installation.

## Dependencies

- This role depends on `levonk.vibeops.dev-python` to ensure a properly configured Python environment is available.
- This role depends on `levonk.vibeops.dev-docker` to ensure Docker is available for Molecule testing.

## License

AGPL-3.0-only

## Author

levonk
