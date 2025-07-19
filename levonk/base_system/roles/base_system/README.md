# Ansible Collection - levonk.base_system

This role provides fundamental system setup and configuration across platforms, including package managers, registry backups, and essential system components.

## Features

### JetBrains Mono Nerd Font (All OS)

Installs the latest patched, full JetBrains Mono Nerd Font from the official Nerd Fonts website for all users on Windows, macOS, and Linux. Ensures consistent developer experience and full glyph support in terminals and editors.

- **Feature defined in:** `docs/requirements/gherkin/jetbrains-mono-nerd-font.feature`
- **Tags:** `font`, `nerd-font`, `jetbrains`, `base_system`, `all_os`
- **Testing:** Molecule scenario should verify font presence and configuration for all OSes.
- **Idempotency:** Font install is safe to run repeatedly; does not duplicate or corrupt fonts.
- **Security:** No insecure script execution; relies on official releases.
- **Configuration:** Attempts to set as default in terminals/editors where possible (see TODO in code).

### Default Shell for New Users (Debian/Ubuntu)

New users created via `adduser` will have `/usr/bin/zsh` as their default shell, providing a modern interactive shell experience by default. Existing users' shells are not modified.

- **Feature defined in:** `docs/requirements/gherkin/default-shell-zsh.feature`
- **Configuration:** Sets `DSHELL=/usr/bin/zsh` in `/etc/adduser.conf`
- **Tags:** `shell`, `zsh`, `base_system`, `useradd`
- **Testing:** Molecule scenario verifies zsh install, config, and user shell assignment.
- **Idempotency:** Task is safe to run repeatedly and does not affect current users.

### Windows Package Manager Installation

Automatically installs WinGet (Windows Package Manager) on Windows systems to provide modern package management capabilities.

- **Variable:** `base_system_install_winget` (default: `true`)
- **Installation method:** Chocolatey package manager
- **Tags:** `base_system`, `windows`, `winget`, `package_manager`

### Windows Registry Backup

This role automatically backs up all major Windows registry hives (HKLM, HKCU, HKU, HKCR, HKCC) to `C:\backup` before making any system changes. This ensures that system state can be restored if needed.

- **Feature defined in:** `docs/requirements/gherkin/windows-registry-backup.feature`
- **OS Support:** Tasks are split into `debian.yml`, `macos.yml`, and `windows.yml` for portability and maintainability.
- **Testing:** Molecule scenario `molecule/windows-registry-backup` verifies backup file creation and idempotency.
- **Security:** No scripts are executed without vetting. All tasks are idempotent and tagged.

See the Gherkin feature file and Molecule tests for full details and expected behavior.

## Role Variables

- `base_system_install_winget`: Install WinGet package manager on Windows (default: `true`)
- `base_system_packages`: List of essential packages to install (define in vars or group_vars)
