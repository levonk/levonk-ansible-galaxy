# Ansible Role: levonk.vibeops.comms

Installs a suite of communication applications on Windows, Debian/Ubuntu, and macOS systems.

## Description

This role automates the installation of essential communication tools like Discord, Slack, Telegram, and others. It is designed to be cross-platform, using the native package manager for each supported operating system (`winget` for Windows, `apt` for Debian, and `homebrew` for macOS).

## Requirements

- **Windows**: `winget` must be installed and accessible.
- **Debian/Ubuntu**: `apt` package manager.
- **macOS**: `homebrew` must be installed.

## Role Variables

The applications to be installed are defined in `defaults/main.yml`. You can override these variables in your playbook or inventory to customize the list of applications.

- `comms_apps_windows`: A list of applications to install on Windows, specified by their `winget` ID and name.

  ```yaml
  comms_apps_windows:
    - id: Discord.Discord
      name: Discord
    - id: Telegram.TelegramDesktop
      name: Telegram
  ```

- `comms_apps_debian`: A list of package names to install on Debian/Ubuntu systems.

  ```yaml
  comms_apps_debian:
    - discord
    - telegram-desktop
  ```

- `comms_apps_darwin`: A list of cask or formula names to install on macOS systems via Homebrew.

  ```yaml
  comms_apps_darwin:
    - discord
    - telegram
  ```

## Dependencies

None.

## Example Playbook

Here is an example of how to use this role in a playbook:

```yaml
---
- hosts: workstations
  become: yes
  roles:
    - role: levonk.vibeops.comms
```

To customize the installed applications, you can define the variables in your playbook:

```yaml
---
- hosts: workstations
  become: yes
  vars:
    comms_apps_windows:
      - id: SlackTechnologies.Slack
        name: Slack
  roles:
    - role: levonk.vibeops.comms
```

## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.

Documentation for the collection.
