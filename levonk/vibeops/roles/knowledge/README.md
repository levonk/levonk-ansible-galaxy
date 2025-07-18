# Ansible Role: levonk.vibeops.knowledge

Installs knowledge management applications (Obsidian, Microsoft Copilot) on supported systems.

## Description

This role automates the installation of essential knowledge management and productivity tools. It is designed to be cross-platform where possible, using the native package manager for each supported operating system (`winget` for Windows, `apt` for Debian, and `homebrew` for macOS).

All installations are conditional and require the `graphical` tag to be specified during the playbook run.

## Requirements

- **Windows**: `winget` must be installed and accessible.
- **Debian/Ubuntu**: `apt` package manager.
- **macOS**: `homebrew` must be installed.

## Role Variables

Installation of each tool is controlled by a boolean variable in `defaults/main.yml`. By default, all are set to `false`. To install a specific tool, set its corresponding variable to `true` and ensure the `graphical` tag is used.

- `knowledge_install_obsidian`: Set to `true` to install Obsidian.
- `knowledge_install_microsoft_copilot`: Set to `true` to install Microsoft Copilot (Windows only).

## Dependencies

None.

## Example Playbook

To install Obsidian on a graphical workstation, define the variable and tag in your playbook:

```yaml
---
- hosts: workstations
  become: yes
  vars:
    knowledge_install_obsidian: true
  roles:
    - role: levonk.vibeops.knowledge
      tags: ["graphical"]
```

## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.
