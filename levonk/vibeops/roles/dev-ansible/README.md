# Ansible Role: levonk.vibeops.dev-ansible

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-ansible)

This role sets up a complete, cross-platform Ansible development environment, including Ansible core, Molecule, linting tools, and all essential plugins for testing and best-practices development on Linux, macOS, and Windows.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-ansible/tasks):

| Feature/Task                 | Description                                        | Required Variable(s)                | Source |
|------------------------------|----------------------------------------------------|-------------------------------------|--------|
| Install Ansible (Linux/macOS)| Installs Ansible via pip for Linux/macOS           | [`ansible_version`](#ansible_version) (optional) | [tasks/main.yml](tasks/main.yml) |
| Install Ansible (Windows)    | Installs Ansible via Chocolatey for Windows        |                                     | [tasks/main.yml](tasks/main.yml) |
| Install dev tools/plugins    | Installs Molecule, molecule-plugins[docker], ansible-lint, yamllint (via pip) | [`dev_ansible_tools`](#dev_ansible_tools) (optional) | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Install Ansible (Linux/macOS)
- **Description:** Installs Ansible using pip. Version can be specified via `ansible_version`.
- **Tags:** `ansible`, `pip`, `linux`, `macos`
- **Idempotency:** Safe to run repeatedly; only updates if not present or version mismatch.
- **Usage:**
  - Set `ansible_version` if a specific version is required.

### Install Ansible (Windows)
- **Description:** Installs Ansible using Chocolatey.
- **Tags:** `ansible`, `windows`, `chocolatey`
- **Idempotency:** Safe to run repeatedly.

### Install dev tools/plugins
- **Description:** Installs Molecule (with Docker plugin), ansible-lint, and yamllint via pip. The list can be customized with `dev_ansible_tools`.
- **Tags:** `molecule`, `testing`, `lint`, `pip`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - Set `dev_ansible_tools` to customize the list of Python packages installed for development.


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
