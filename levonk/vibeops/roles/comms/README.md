# Ansible Role: levonk.vibeops.comms

Installs a suite of communication applications on Windows, Debian/Ubuntu, and macOS systems.

## Description

This role automates the installation of essential communication tools like Discord, Slack, Telegram, and others. It is designed to be cross-platform, using the native package manager for each supported operating system (`winget` for Windows, `apt` for Debian, and `homebrew` for macOS).

## Requirements

- **Windows**: `winget` must be installed and accessible.
- **Debian/Ubuntu**: `apt` package manager.
- **macOS**: `homebrew` must be installed.

## Role Variables

Installation of each communication tool is controlled by a boolean variable in `defaults/main.yml`. By default, all are set to `false`. To install a specific tool, set its corresponding variable to `true` in your playbook or inventory.

- `comms_install_discord`: Set to `true` to install Discord.
- `comms_install_telegram`: Set to `true` to install Telegram.
- `comms_install_signal`: Set to `true` to install Signal.
- `comms_install_slack`: Set to `true` to install Slack.
- `comms_install_zoom`: Set to `true` to install Zoom.
- `comms_install_teams`: Set to `true` to install Microsoft Teams.
- `comms_install_google_meet`: Set to `true` to install Google Meet.

## Dependencies

None.

## Example Playbook

To install Discord and Slack, define the variables in your playbook like this:

```yaml
---
- hosts: workstations
  become: yes
  vars:
    comms_install_discord: true
    comms_install_slack: true
  roles:
    - role: levonk.vibeops.comms
```

## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.

Documentation for the collection.
