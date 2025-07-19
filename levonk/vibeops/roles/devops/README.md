# Ansible Role: levonk.vibeops.devops

Installs essential DevOps tools (Vagrant, Packer, Terraform, Docker Desktop, VirtualBox, gitkeeper) on Windows, Debian/Ubuntu, and macOS systems.

## Description

This role automates the installation of HashiCorp Vagrant, Packer, Terraform, Docker Desktop, VirtualBox/Guest Additions, and the gitkeeper CLI tool. It intelligently detects the environment and installs VirtualBox Guest Additions when running in a VirtualBox VM, or VirtualBox itself when running on bare metal. It is designed to be cross-platform, using the most appropriate package manager or build tool for each supported operating system.

## Requirements

- **Windows**: Chocolatey and Winget package managers must be installed.
- **Debian/Ubuntu**: `apt` package manager.
- **macOS**: Homebrew package manager must be installed.
- For `gitkeeper`, a working **Go** development environment is required (e.g., via the `levonk.dev_setup.dev-go` role).

## Role Variables

Installation of some tools is controlled by boolean variables.

- `devops_install_gitkeeper`: Set to `true` to install the gitkeeper CLI tool.

## Tags

The role's behavior is also controlled via tags.

- **`vagrant`**: Run only the tasks required to install Vagrant.
- **`packer`**: Run only the tasks required to install Packer.
- **`terraform`**: Run only the tasks required to install Terraform.
- **`virtualbox`**: Run only the VirtualBox-related tasks (Guest Additions or VirtualBox installation).
- **`graphical`**: Run tasks that require a graphical environment, such as installing Docker Desktop or X11 Guest Additions.

If no tags are specified, the role will install Vagrant, Packer, Terraform, and VirtualBox/Guest Additions, but not graphical applications or tools controlled by variables.

## Dependencies

- The `gitkeeper` task requires a Go environment.

## Example Playbook

To install Vagrant, Packer, Terraform, and VirtualBox/Guest Additions:

```yaml
---
- hosts: workstations
  become: yes
  roles:
    - role: levonk.vibeops.devops
```

To install gitkeeper:

```yaml
---
- hosts: workstations
  become: yes
  vars:
    devops_install_gitkeeper: true
  roles:
    - role: levonk.vibeops.devops
```

To install with X11 Guest Additions (when running in VirtualBox VM):

```yaml
---
- hosts: vms
  become: yes
  roles:
    - role: levonk.vibeops.devops
  tags:
    - graphical
```

## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.
