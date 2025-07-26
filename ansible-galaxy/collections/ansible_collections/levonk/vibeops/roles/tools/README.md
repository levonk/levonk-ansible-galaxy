# Ansible Role: levonk.vibeops.tools

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/tools)

This role provisions a cross-platform suite of general-purpose tools and utilities, with platform-specific and opt-in features, using best-practices variable and feature documentation.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/tools/tasks):

| Feature/Task         | Description                                   | Required Variable(s)                  | Source |
|----------------------|-----------------------------------------------|---------------------------------------|--------|
| Install SSH client/server (Linux/macOS) | Ensures SSH present on Unix platforms | *(none)* | [tasks/ssh_unix.yml](tasks/ssh_unix.yml) |
| Install SSH client/server (Windows)     | Ensures SSH present on Windows        | *(none)* | [tasks/ssh_windows.yml](tasks/ssh_windows.yml) |
| Install macOS-specific tools            | Installs AltTab, Stats, Keka, etc.    | *(see variables)* | [tasks/darwin.yml](tasks/darwin.yml) |
| Install Windows-specific tools          | Installs PowerToys, WinGet, etc.      | *(see variables)* | [tasks/windows.yml](tasks/windows.yml) |
| Install clipboard managers              | Installs Ditto, CopyQ, CopyClip       | *(none)* | [tasks/clipboard_managers.yml](tasks/clipboard_managers.yml) |
| Install terminal applications           | Installs Windows Terminal, Tilix, iTerm2 | *(none)* | [tasks/terminals.yml](tasks/terminals.yml) |
| Install Raycast launcher                | Installs Raycast (macOS, Debian)      | *(none)* | [tasks/raycast.yml](tasks/raycast.yml) |
| Install 7-Zip                           | Installs 7-Zip or compatible archiver | `tools_install_7zip` | [tasks/7zip.yml](tasks/7zip.yml) |
| Install Sublime Text                    | Installs Sublime Text editor          | `tools_install_sublime_text` | [tasks/sublime_text.yml](tasks/sublime_text.yml) |
| Install git-friendly                    | Installs git-friendly scripts         | `tools_install_git_friendly` | [tasks/git_friendly.yml](tasks/git_friendly.yml) |
| Install Atuin shell history manager     | Installs Atuin for shell history      | `tools_install_atuin` | [tasks/atuin.yml](tasks/atuin.yml) |
| Install Halp command-line tool          | Installs Halp CLI                     | `tools_install_halp` | [tasks/halp.yml](tasks/halp.yml) |
| Install Tealdeer (tldr)                 | Installs Tealdeer/tldr pages          | `tools_install_tealdeer` | [tasks/tealdeer.yml](tasks/tealdeer.yml) |
| Install Espanso                         | Installs Espanso text expander        | `tools_install_espanso` | [tasks/espanso.yml](tasks/espanso.yml) |
| Install Speech Tools                    | Installs speech/voice control tools   | `tools_install_speech_tools` | [tasks/speech.yml](tasks/speech.yml) |
| Install diagram tools                   | Installs Graphviz, MermaidJS, Archi   | *(none)* | [tasks/diagram-tools.yml](tasks/diagram-tools.yml) |
| Install Archi diagram tool              | Installs Archi/ArchiMate tool         | *(none)* | [tasks/archi-diagrams.yml](tasks/archi-diagrams.yml) |

---

## Detailed Feature Documentation

### SSH client/server (Linux/macOS/Windows)
**Description:** Ensures SSH client and server are present and configured for secure remote access on all platforms.
- **Supported Platforms:** Windows, macOS, Linux
- **Tags:** `ssh`, `tools`, `security`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official package sources.
- **Usage:** No variables required, runs automatically per OS.

### macOS-specific tools
**Description:** Installs AltTab, Stats, Hidden, Itsycal, Time Out, KeepingYouAwake, Keka, and more for enhanced macOS experience. Controlled by `tools_install_*` variables (default true on macOS).
- **Supported Platforms:** macOS
- **Tags:** `tools`, `macos`, `graphical`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses Homebrew or trusted sources.
- **Usage:** Set `tools_install_*` variables as needed.

### Windows-specific tools
**Description:** Installs PowerToys, WinGet, Windows Terminal, Everything, AutoHotkey, Sysinternals, ShareX, Notepad++. Controlled by `tools_install_*` variables (default true on Windows).
- **Supported Platforms:** Windows
- **Tags:** `tools`, `windows`, `graphical`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses Chocolatey/WinGet or trusted sources.
- **Usage:** Set `tools_install_*` variables as needed.

### Clipboard managers, terminals, Raycast, 7-Zip, Sublime Text, git-friendly, Atuin, Halp, Tealdeer, Espanso, Speech Tools, diagram tools
**Description:** Installs a variety of cross-platform and OS-specific utilities for productivity, text expansion, shell history, diagrams, and more. Controlled by `tools_install_*` variables (see below).
- **Supported Platforms:** Windows, macOS, Linux
- **Tags:** `tools`, `productivity`, `graphical`, `cli`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official or trusted sources.
- **Usage:** Set `tools_install_*` variables as needed.

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

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| `tools_install_7zip` | `false` | `true` | bool | opt-in | Install 7-Zip or compatible archiver | [tasks/7zip.yml](tasks/7zip.yml) |
| `tools_install_sublime_text` | `false` | `true` | bool | opt-in | Install Sublime Text editor | [tasks/sublime_text.yml](tasks/sublime_text.yml) |
| `tools_install_espanso` | `false` | `true` | bool | opt-in | Install Espanso text expander | [tasks/espanso.yml](tasks/espanso.yml) |
| `tools_install_speech_tools` | `false` | `true` | bool | opt-in | Install speech/voice control tools | [tasks/speech.yml](tasks/speech.yml) |
| `tools_install_alttab` | `true` | `false` | bool | opt-out | Install AltTab (macOS) | [tasks/darwin.yml](tasks/darwin.yml) |
| `tools_install_stats` | `true` | `false` | bool | opt-out | Install Stats (macOS) | [tasks/darwin.yml](tasks/darwin.yml) |
| `tools_install_hidden` | `true` | `false` | bool | opt-out | Install Hidden (macOS) | [tasks/darwin.yml](tasks/darwin.yml) |
| `tools_install_itsycal` | `true` | `false` | bool | opt-out | Install Itsycal (macOS) | [tasks/darwin.yml](tasks/darwin.yml) |
| `tools_install_timeout` | `true` | `false` | bool | opt-out | Install Time Out (macOS) | [tasks/darwin.yml](tasks/darwin.yml) |
| `tools_install_keepingyouawake` | `true` | `false` | bool | opt-out | Install KeepingYouAwake (macOS) | [tasks/darwin.yml](tasks/darwin.yml) |
| `tools_install_keka` | `true` | `false` | bool | opt-out | Install Keka (macOS) | [tasks/darwin.yml](tasks/darwin.yml) |
| `tools_install_powertoys` | `true` | `false` | bool | opt-out | Install PowerToys (Windows) | [tasks/windows.yml](tasks/windows.yml) |
| `tools_install_windows_terminal` | `true` | `false` | bool | opt-out | Install Windows Terminal | [tasks/windows.yml](tasks/windows.yml) |
| `tools_install_everything` | `true` | `false` | bool | opt-out | Install Everything search (Windows) | [tasks/windows.yml](tasks/windows.yml) |
| `tools_install_autohotkey` | `true` | `false` | bool | opt-out | Install AutoHotkey (Windows) | [tasks/windows.yml](tasks/windows.yml) |
| `tools_install_sysinternals` | `true` | `false` | bool | opt-out | Install Sysinternals Suite (Windows) | [tasks/windows.yml](tasks/windows.yml) |
| `tools_install_sharex` | `true` | `false` | bool | opt-out | Install ShareX (Windows) | [tasks/windows.yml](tasks/windows.yml) |
| `tools_install_notepadplusplus` | `true` | `false` | bool | opt-out | Install Notepad++ (Windows) | [tasks/windows.yml](tasks/windows.yml) |
| `tools_install_m1f` | `false` | `true` | bool | opt-in | Install m1f tool | [tasks/m1f.yml](tasks/m1f.yml) |
| `m1f_version` | `latest` | `v1.0.0` | string | opt-in | Version of m1f to install | [tasks/m1f.yml](tasks/m1f.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Windows, macOS, Linux (Debian, RedHat, Archlinux)
- Platform-specific: Chocolatey/WinGet (Windows), Homebrew (macOS), apt/dnf/pacman (Linux)

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  vars:
    tools_install_sublime_text: true
    tools_install_7zip: true
  roles:
    - role: levonk.vibeops.tools
      tags: ["graphical"]
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

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the MIT License. See LICENSE file in the project root for full license information.

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
