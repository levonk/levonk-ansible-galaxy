# Ansible Role - levonk.vibeops.browsers

This role provides automated installation and configuration of multiple web browsers across different operating systems. It supports developer-focused browsers, privacy-focused options, and gaming-optimized browsers to meet diverse user needs in development, testing, and daily use scenarios.

## Supported Browsers

- Firefox Developer Edition
- Google Chrome
- Chromium
- Microsoft Edge
- Opera GX (performance-focused)
- Brave (privacy-focused)
- Dia (development workflows)
- BrowserOS (specialized browser OS)

## Supported Platforms

- Windows (winget, chocolatey)
- macOS (Homebrew)
- Linux (apt, yum, dnf, pacman)

## Dependencies

This role depends on:

- `levonk.base_system.base_system` - For package manager setup (chocolatey on Windows)
- `levonk.user_setup.local_user` - For user-specific configurations
- `levonk.user_setup.chezmoi` - For dotfiles management integration

## Tags

- `graphical-user` - Required tag since all browsers need GUI environment
- `browsers` - Install all browsers
- `firefox` - Install only Firefox Developer Edition
- `chrome` - Install only Chrome/Chromium
- `privacy` - Install privacy-focused browsers (Brave)
- `performance` - Install performance-optimized browsers (Opera GX)

## Usage

```yaml
- hosts: localhost
  roles:
    - role: levonk.vibeops.browsers
      tags: ["graphical-user", "browsers"]
```

## Configuration

Browser configurations are managed through chezmoi templates and can be customized via data files in the dotfiles repository.
