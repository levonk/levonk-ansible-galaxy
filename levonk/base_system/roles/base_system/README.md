# Ansible Collection - levonk.base_system

This role provides fundamental system setup and configuration across platforms, including package managers, registry backups, and essential system components.

## Features

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
