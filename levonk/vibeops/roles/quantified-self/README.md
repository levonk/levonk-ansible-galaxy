# Ansible Role: levonk.vibeops.quantified-self

This role installs and configures quantified self tools for personal productivity tracking and analytics.

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

## Dependencies

This role depends on:
- `levonk.base_system` (for package managers)
- `community.general` (for Homebrew)
- `chocolatey.chocolatey` (for Windows)
- `community.windows` (for WinGet)

## License

AGPL-3.0-only

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