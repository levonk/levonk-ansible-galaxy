# Ansible Role: levonk.vibeops.comms

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/comms)

This role installs and configures a suite of popular communication tools (Discord, Telegram, Signal, Slack, Zoom, Microsoft Teams, Google Meet) across Linux, macOS, and Windows. It is cross-platform and idempotent, using the native package manager for each OS.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/comms/tasks):

| Feature/Task            | Description                                 | Required Variable(s)                | Source |
|-------------------------|---------------------------------------------|-------------------------------------|--------|
| Install Discord         | Installs Discord desktop client             | [`comms_install_discord`](#comms_install_discord) | [tasks/discord.yml](tasks/discord.yml) |
| Install Telegram        | Installs Telegram desktop client            | [`comms_install_telegram`](#comms_install_telegram) | [tasks/telegram.yml](tasks/telegram.yml) |
| Install Signal          | Installs Signal desktop client              | [`comms_install_signal`](#comms_install_signal) | [tasks/signal.yml](tasks/signal.yml) |
| Install Slack           | Installs Slack desktop client               | [`comms_install_slack`](#comms_install_slack) | [tasks/slack.yml](tasks/slack.yml) |
| Install Zoom            | Installs Zoom video conferencing client     | [`comms_install_zoom`](#comms_install_zoom) | [tasks/zoom.yml](tasks/zoom.yml) |
| Install Microsoft Teams | Installs Microsoft Teams client             | [`comms_install_teams`](#comms_install_teams) | [tasks/teams.yml](tasks/teams.yml) |
| Install Google Meet     | Installs Google Meet desktop integration    | [`comms_install_google_meet`](#comms_install_google_meet) | [tasks/google_meet.yml](tasks/google_meet.yml) |

---

## Detailed Feature Documentation

### Install Communication Tools
**Description:**
> Each tool is installed only if its corresponding variable is set to `true`. Uses platform-native package managers: `apt` (Debian/Ubuntu), `brew` (macOS), and `winget` (Windows). Each tool is included as a separate task file for modularity.
- **Tags:** `comms`, `chat`, `video`, `messaging`
- **Idempotency:** Each install is safe to run repeatedly.
- **Usage:**
  - Set `comms_install_<tool>` to `true` to enable installation of that tool.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable                              | Default | Sample Value | Type  | Activation | Purpose                                | Used In |
|----------------------------------------|---------|--------------|-------|------------|----------------------------------------|---------|
| <a name="comms_install_discord"></a>`comms_install_discord`         | `false` | `true`       | bool  | opt-in     | Install Discord                        | [tasks/discord.yml](tasks/discord.yml) |
| <a name="comms_install_telegram"></a>`comms_install_telegram`       | `false` | `true`       | bool  | opt-in     | Install Telegram                       | [tasks/telegram.yml](tasks/telegram.yml) |
| <a name="comms_install_signal"></a>`comms_install_signal`           | `false` | `true`       | bool  | opt-in     | Install Signal                         | [tasks/signal.yml](tasks/signal.yml) |
| <a name="comms_install_slack"></a>`comms_install_slack`             | `false` | `true`       | bool  | opt-in     | Install Slack                          | [tasks/slack.yml](tasks/slack.yml) |
| <a name="comms_install_zoom"></a>`comms_install_zoom`               | `false` | `true`       | bool  | opt-in     | Install Zoom                           | [tasks/zoom.yml](tasks/zoom.yml) |
| <a name="comms_install_teams"></a>`comms_install_teams`             | `false` | `true`       | bool  | opt-in     | Install Microsoft Teams                | [tasks/teams.yml](tasks/teams.yml) |
| <a name="comms_install_google_meet"></a>`comms_install_google_meet` | `false` | `true`       | bool  | opt-in     | Install Google Meet                    | [tasks/google_meet.yml](tasks/google_meet.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, RedHat, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `brew` (macOS), `winget` (Windows)

---

### Dependencies
- None

---

### Example Playbook
```yaml
- hosts: all
  become: yes
  vars:
    comms_install_discord: true
    comms_install_slack: true
    comms_install_telegram: false
    comms_install_signal: false
    comms_install_zoom: false
    comms_install_teams: false
    comms_install_google_meet: false
  roles:
    - role: levonk.vibeops.comms
```

---

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License
Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the MIT License. See LICENSE file in the project root for full license information.
