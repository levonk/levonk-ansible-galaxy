# dev-ansible Role

This role sets up an Ansible development environment for users or CI systems. It supports:
- Ansible and dependencies install (pip or system)
- Linting, molecule, and test setup
- Common plugins and collections

## Variables
- `ansible_version`: Ansible version to install
- `dev_ansible_tools`: List of tools/plugins to install

## Compliance
- Follows secure install practices
- Supports reproducible builds

## Testing
- Molecule scenario included for install and environment checks
