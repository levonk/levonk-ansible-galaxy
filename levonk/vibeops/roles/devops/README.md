# Ansible Role: levonk.vibeops.devops

Installs essential DevOps tools (Vagrant, Packer) on Windows, Debian/Ubuntu, and macOS systems.

## Description

This role automates the installation of HashiCorp Vagrant and Packer. It is designed to be cross-platform, using the most appropriate package manager for each supported operating system (`chocolatey` for Windows, `apt` for Debian, and `homebrew` for macOS).

## Requirements

- **Windows**: Chocolatey package manager must be installed and accessible in the system's PATH.
- **Debian/Ubuntu**: `apt` package manager.
- **macOS**: Homebrew package manager must be installed.

## Role Variables

This role does not require any variables to be set. Its behavior is controlled via tags.

- **`vagrant`**: Run only the tasks required to install Vagrant.
- **`packer`**: Run only the tasks required to install Packer.

If no tags are specified, the role will install both applications.

## Dependencies

None.

## Example Playbook

Here is an example of how to use this role in a playbook to install both tools:

```yaml
---
- hosts: workstations
  become: yes
  roles:
    - role: levonk.vibeops.devops
```

To install only Vagrant, you can use tags:

```yaml
---
- hosts: workstations
  become: yes
  roles:
    - role: levonk.vibeops.devops
      tags: ["vagrant"]
```

## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.
