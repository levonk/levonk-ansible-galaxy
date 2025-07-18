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

## Requirements

-   For Windows, Chocolatey and Winget are required.
-   For macOS, Homebrew is required.

## Role Variables

Installation of some tools is controlled by boolean variables. By default, all are set to `false`. To install a specific tool, set its corresponding variable to `true` and ensure the `graphical` tag is used.

- `tools_install_7zip`: Set to `true` to install 7-Zip (or a compatible alternative).
- `tools_install_sublime_text`: Set to `true` to install Sublime Text.
- `tools_install_espanso`: Set to `true` to install Espanso.
- `tools_install_speech_tools`: Set to `true` to enable/install speech recognition and voice control tools.

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
