# Ansible Role: levonk.vibeops.quantified-self

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/quantified-self)

This role provisions cross-platform quantified self tools, including ActivityWatch (open source), Rize, and Fathom (commercial), with best-practices variable and feature documentation.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/quantified-self/tasks):

| Feature/Task         | Description                                   | Required Variable(s)                  | Source |
|----------------------|-----------------------------------------------|---------------------------------------|--------|
| Install ActivityWatch| Installs ActivityWatch (open source tracker)  | `quantified_self_install_activitywatch`| [tasks/install_activitywatch.yml](tasks/install_activitywatch.yml) |
| Install Rize         | Installs Rize (commercial tracker)            | `quantified_self_install_rize`        | [tasks/install_rize.yml](tasks/install_rize.yml) |
| Install Fathom       | Installs Fathom (meeting recorder)            | `quantified_self_install_fathom`      | [tasks/install_fathom.yml](tasks/install_fathom.yml) |
| Configure tools      | Sets up config, autostart, directories        | `quantified_self_configure_startup`   | [tasks/configure.yml](tasks/configure.yml) |

---

## Detailed Feature Documentation

### Install ActivityWatch
**Description:** Installs ActivityWatch on Windows (Chocolatey/WinGet), macOS (Homebrew), and Linux (AppImage). Controlled by `quantified_self_install_activitywatch` (opt-out, default true). Supports autostart and version selection.
- **Supported Platforms:** Windows, macOS, Linux
- **Tags:** `quantified-self`, `activitywatch`, `productivity`, `analytics`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official sources or GitHub releases.
- **Usage:** Set `quantified_self_install_activitywatch: true|false` as needed.

### Install Rize
**Description:** Installs Rize on Windows (WinGet) and macOS (Homebrew). Controlled by `quantified_self_install_rize` (opt-in, default false). Commercial software.
- **Supported Platforms:** Windows, macOS
- **Tags:** `quantified-self`, `rize`, `productivity`, `analytics`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official sources.
- **Usage:** Set `quantified_self_install_rize: true` to enable.

### Install Fathom
**Description:** Installs Fathom on Windows (WinGet), macOS (Homebrew), and Linux (AppImage). Controlled by `quantified_self_install_fathom` (opt-in, default false). Commercial software.
- **Supported Platforms:** Windows, macOS, Linux
- **Tags:** `quantified-self`, `fathom`, `productivity`, `analytics`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official sources.
- **Usage:** Set `quantified_self_install_fathom: true` to enable.

### Configure quantified-self tools
**Description:** Creates config directories, sets up autostart, manages desktop shortcuts, and configures ActivityWatch settings. Controlled by `quantified_self_configure_startup` (opt-out, default true).
- **Supported Platforms:** Windows, macOS, Linux
- **Tags:** `quantified-self`, `configure`, `startup`, `desktop`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Only modifies user config directories.
- **Usage:** Set `quantified_self_configure_startup: true|false` as needed.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

---

#### Variable Reference

| Variable                                | Default   | Sample Value | Type   | Activation | Purpose                                   | Used In |
|------------------------------------------|-----------|--------------|--------|------------|-------------------------------------------|---------|
| `quantified_self_install_activitywatch`  | `true`    | `false`      | bool   | opt-out     | Installs ActivityWatch tracker            | [tasks/install_activitywatch.yml](tasks/install_activitywatch.yml) |
| `quantified_self_activitywatch_autostart`| `true`    | `false`      | bool   | opt-out     | Autostart ActivityWatch                   | [tasks/configure.yml](tasks/configure.yml) |
| `quantified_self_activitywatch_version`  | `latest`  | `0.12.2`     | string | opt-out     | ActivityWatch version to install          | [tasks/install_activitywatch.yml](tasks/install_activitywatch.yml) |
| `quantified_self_install_rize`           | `false`   | `true`       | bool   | opt-in      | Installs Rize tracker (commercial)        | [tasks/install_rize.yml](tasks/install_rize.yml) |
| `quantified_self_rize_autostart`         | `true`    | `false`      | bool   | opt-out     | Autostart Rize                            | [tasks/configure.yml](tasks/configure.yml) |
| `quantified_self_install_fathom`         | `false`   | `true`       | bool   | opt-in      | Installs Fathom meeting recorder          | [tasks/install_fathom.yml](tasks/install_fathom.yml) |
| `quantified_self_fathom_autostart`       | `true`    | `false`      | bool   | opt-out     | Autostart Fathom                          | [tasks/configure.yml](tasks/configure.yml) |
| `quantified_self_create_desktop_shortcuts`| `true`   | `false`      | bool   | opt-out     | Create desktop shortcuts                  | [tasks/configure.yml](tasks/configure.yml) |
| `quantified_self_configure_startup`      | `true`    | `false`      | bool   | opt-out     | Configure startup for tools               | [tasks/configure.yml](tasks/configure.yml) |
| `quantified_self_prefer_winget`          | `true`    | `false`      | bool   | opt-out     | Prefer WinGet on Windows                  | [tasks/install_activitywatch.yml](tasks/install_activitywatch.yml) |
| `quantified_self_prefer_homebrew`        | `true`    | `false`      | bool   | opt-out     | Prefer Homebrew on macOS                  | [tasks/install_activitywatch.yml](tasks/install_activitywatch.yml) |
| `quantified_self_prefer_apt`             | `true`    | `false`      | bool   | opt-out     | Prefer apt on Debian/Ubuntu               | [tasks/install_activitywatch.yml](tasks/install_activitywatch.yml) |
| `quantified_self_enable_services`        | `true`    | `false`      | bool   | opt-out     | Enable services for installed tools       | [tasks/configure.yml](tasks/configure.yml) |
| `quantified_self_start_services`         | `true`    | `false`      | bool   | opt-out     | Start services for installed tools        | [tasks/configure.yml](tasks/configure.yml) |

---

### Requirements
- Ansible 2.12+
- Python 3.6+
- Supported platforms: Windows 10/11, macOS 10.14+, Ubuntu 18.04+/Debian 10+/EL8+
- Platform-specific: Chocolatey/WinGet (Windows), Homebrew (macOS), AppImage/apt (Linux)

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  vars:
    quantified_self_install_activitywatch: true
    quantified_self_install_rize: false
    quantified_self_install_fathom: false
  roles:
    - role: levonk.vibeops.quantified-self
```

---

## Best Practices for Role Documentation

- **Always document every variable** in a table with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- **Link to the source** of each feature/task and variable usage for transparency and maintainability.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Reference external specs or requirements** where relevant.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new roles and features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the AGPL-3.0-only License. See LICENSE file in the project root for full license information.

## Features

This role installs and configures the following quantified self tools:

### ActivityWatch (Open Source)
- **Description**: Open source automated time tracker and productivity analytics
- **Platforms**: Windows, macOS, Linux
- **Installation**: Chocolatey/WinGet (Windows), Homebrew (macOS), AppImage (Linux)
- **Features**: Automatic time tracking, web activity monitoring, application usage analytics
- **Default**: Enabled (`quantified_self_install_activitywatch: true`)

### Rize (Commercial)
- **Description**: Commercial computer activity tracker with advanced analytics
- **Platforms**: Windows, macOS
- **Installation**: WinGet (Windows), Homebrew (macOS)
- **Features**: Detailed productivity insights, focus time tracking, break reminders
- **Default**: Disabled (`quantified_self_install_rize: false`) - Commercial software, opt-in

### Fathom (Commercial)
- **Description**: Meeting recorder and transcription tool
- **Platforms**: Windows, macOS, Linux (AppImage)
- **Installation**: WinGet (Windows), Homebrew (macOS), AppImage (Linux)
- **Features**: Meeting recording, transcription, note-taking
- **Default**: Disabled (`quantified_self_install_fathom: false`) - Commercial software, opt-in

## Requirements

### System Requirements
- **Windows**: Windows 10/11 with Chocolatey or WinGet
- **macOS**: macOS 10.14+ with Homebrew
- **Linux**: Ubuntu 18.04+, Debian 10+, CentOS 8+, or Arch Linux

### Dependencies
- Package managers (auto-installed by base_system role):
  - Windows: Chocolatey and/or WinGet
  - macOS: Homebrew
  - Linux: System package manager (apt, dnf, pacman)

## Role Variables

### Tool Installation Control
```yaml
# ActivityWatch (open source)
quantified_self_install_activitywatch: true
quantified_self_activitywatch_autostart: true
quantified_self_activitywatch_version: "latest"

# Rize (commercial)
quantified_self_install_rize: false  # Opt-in for commercial software
quantified_self_rize_autostart: true

# Fathom (commercial)
quantified_self_install_fathom: false  # Opt-in for commercial software
quantified_self_fathom_autostart: true
```

### General Configuration
```yaml
# Desktop and startup configuration
quantified_self_create_desktop_shortcuts: true
quantified_self_configure_startup: true

# Service management
quantified_self_enable_services: true
quantified_self_start_services: true

# Package manager preferences (auto-detected)
quantified_self_prefer_winget: true    # Windows
quantified_self_prefer_homebrew: true  # macOS
quantified_self_prefer_apt: true       # Linux
```

## Example Playbook

### Basic Installation (ActivityWatch only)
```yaml
- hosts: all
  roles:
    - levonk.vibeops.quantified-self
```

### Full Installation (All Tools)
```yaml
- hosts: all
  roles:
    - role: levonk.vibeops.quantified-self
      vars:
        quantified_self_install_activitywatch: true
        quantified_self_install_rize: true
        quantified_self_install_fathom: true
        quantified_self_create_desktop_shortcuts: true
```

### Selective Installation with Tags
```bash
# Install only ActivityWatch
ansible-playbook playbook.yml --tags "activitywatch"

# Install commercial tools only
ansible-playbook playbook.yml --tags "rize,fathom"

# Configure without installing
ansible-playbook playbook.yml --tags "configure"
```

## Platform-Specific Notes

### Windows
- Uses Chocolatey as primary package manager with WinGet fallback
- Creates startup shortcuts in user's Startup folder
- Installs to `%LOCALAPPDATA%\Programs` or `%PROGRAMFILES%`

### macOS
- Uses Homebrew casks for application installation
- Configures login items for autostart
- Installs to `/Applications`

### Linux
- ActivityWatch: Downloads and installs AppImage to `~/.local/share/activitywatch`
- Fathom: Downloads AppImage if available
- Rize: Not supported on Linux (displays notice)
- Creates desktop entries and autostart configurations

## Security Considerations

- All tools handle personal productivity data
- ActivityWatch data is stored locally by default
- Commercial tools (Rize, Fathom) may have cloud sync features
- Review privacy settings after installation
- Consider data retention policies for compliance

## Troubleshooting

### Common Issues

1. **Package Manager Not Found**
   - Ensure base_system role has run first
   - Verify package manager installation

2. **Permission Errors**
   - Run with appropriate user permissions
   - Check directory permissions for config/data folders

3. **Autostart Not Working**
   - Verify desktop environment supports autostart
   - Check autostart directory permissions

4. **Commercial Software Installation Fails**
   - Verify software availability in package repositories
   - Check for manual installation requirements

### Verification Commands

```bash
# Check ActivityWatch installation
activitywatch --version

# Verify services (Linux)
systemctl --user status activitywatch

# Check autostart entries
ls ~/.config/autostart/
```


## Author Information

This role was created by [levonk](https://github.com/levonk) as part of the levonk.vibeops collection for personal productivity and quantified self workflows.

## Tags

- `quantified-self`
- `activitywatch`
- `rize`
- `fathom`
- `productivity`
- `time-tracking`
- `analytics`
- `windows`
- `macos`
- `linux`