# Ansible Role: levonk.vibeops.tools

This role installs a collection of general-purpose tools, with support for conditional installation of graphical applications.

## Description

This role is designed to be a centralized place for installing common utilities. When the `graphical` tag is used, it can install OS-specific tools for an enhanced graphical environment:

-   **Clipboard Managers**: Ditto (Windows), CopyQ (Debian), CopyClip (macOS).
-   **Terminals**: Windows Terminal, Tilix (Debian), iTerm2 (macOS).
-   **Launchers**: Raycast (macOS, Debian).
-   **Utilities**: 7-Zip (Windows), Keka (macOS), p7zip-full (Debian).
-   **Editors**: Sublime Text.
-   **Text Expanders**: Espanso.
-   **Speech and Voice Control**: Enables native OS features and installs tools like Simon, Whisper CLI, and Dragonfly.

### Platform-Specific Tools

**macOS Tools** (installed by default on macOS):
-   **AltTab**: Windows-style alt-tab switcher
-   **Stats**: System monitor in menu bar
-   **Hidden**: Hide/show menu bar items
-   **Itsycal**: Menu bar calendar
-   **Time Out**: Break reminder tool
-   **KeepingYouAwake**: Prevent system sleep
-   **Keka**: File archiver and compressor

**Windows Tools** (installed by default on Windows):
-   **PowerToys**: Windows system utilities and enhancements
-   **WinGet**: Windows package manager
-   **Windows Terminal**: Modern terminal application
-   **Everything**: Instant file and folder search
-   **AutoHotkey**: Automation and scripting tool
-   **Sysinternals Suite**: Advanced system utilities
-   **ShareX**: Screenshot and screen recording tool
-   **Notepad++**: Advanced text editor

## Requirements

-   For Windows, Chocolatey and Winget are required.
-   For macOS, Homebrew is required.

## Role Variables

Installation of some tools is controlled by boolean variables. Platform-specific tools are enabled by default on their respective platforms for better user experience.

### Cross-Platform Tools (default: false)
- `tools_install_7zip`: Set to `true` to install 7-Zip (or a compatible alternative).
- `tools_install_sublime_text`: Set to `true` to install Sublime Text.
- `tools_install_espanso`: Set to `true` to install Espanso.
- `tools_install_speech_tools`: Set to `true` to enable/install speech recognition and voice control tools.

### macOS-Specific Tools (default: true)
- `tools_install_alttab`: Install AltTab window switcher
- `tools_install_stats`: Install Stats system monitor
- `tools_install_hidden`: Install Hidden menu bar manager
- `tools_install_itsycal`: Install Itsycal menu bar calendar
- `tools_install_timeout`: Install Time Out break reminder
- `tools_install_keepingyouawake`: Install KeepingYouAwake sleep prevention
- `tools_install_keka`: Install Keka file archiver

### Windows-Specific Tools (default: true)
- `tools_install_powertoys`: Install PowerToys system utilities
- `tools_install_winget`: Install WinGet package manager
- `tools_install_windows_terminal`: Install Windows Terminal
- `tools_install_everything`: Install Everything file search
- `tools_install_autohotkey`: Install AutoHotkey automation
- `tools_install_sysinternals`: Install Sysinternals Suite
- `tools_install_sharex`: Install ShareX screenshot tool
- `tools_install_notepadplusplus`: Install Notepad++ text editor

## Dependencies

None.

## Example Playbook

To install a specific tool like Sublime Text, define the variable in your playbook and run Ansible with the `graphical` tag:

**playbook.yml:**
```yaml
---
- hosts: all
  vars:
    tools_install_sublime_text: true
  roles:
    - role: levonk.vibeops.tools
```

**Command:**
```bash
ansible-playbook playbook.yml --tags graphical
```

## License

Copyright (c) 2025, Brillarc, LLC

## Author Information

This role was created in 2025 by Brillarc, LLC.
