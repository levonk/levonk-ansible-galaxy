# Ansible Role: levonk.base_system.base_system

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/base_system/roles/base_system)

This role provides fundamental system setup and configuration across platforms, including package managers, registry backups, and essential system components.

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/base_system/roles/base_system/tasks):

| Feature/Task | Description | Required Variable(s) | Source |
|--------------|-------------|----------------------|--------|
| Set Hostname | Sets the system hostname | [`system_hostname`](#system_hostname) | [system/hostname.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/system/hostname.yml) |
| Set Timezone & NTP | Sets system timezone and configures NTP (cross-platform) | [`timezone`](#timezone), [`ntp_servers`](#ntp_servers) | [system/timezone.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/system/timezone.yml) |
| Base System Packages | Installs a list of essential packages | [`base_system_packages`](#base_system_packages) | [base_packages.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/base_packages.yml) |
| Fonts | Installs JetBrains Mono Nerd Font (all OSes) | *(none)* | [fonts.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/fonts.yml) |
| Shell Setup | Ensures zsh is installed and default for new users (Debian/Ubuntu) | *(none)* | [shell_setup.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/shell_setup.yml) |
| Package Manager Config | Configures APT, YUM, Homebrew, Chocolatey, AUR as needed | *(none)* | [package-managers/](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/base_system/roles/base_system/tasks/package-managers) |
| Windows Package Manager | Installs WinGet (Windows only) | [`base_system_install_winget`](#base_system_install_winget) | [package-managers/chocolatey.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/package-managers/chocolatey.yml) |


### Graphical Subsystem Setup (Debian)

Installs and configures a graphical desktop environment (XFCE4, LightDM, dbus-x11, VirtualBox guest additions) if the `graphical` tag is set. Ensures GUI support for Vagrant/VirtualBox and other desktop use cases.

- **Feature defined in:** `docs/requirements/gherkin/install_graphical_subsystem.feature`
- **Tags:** `graphical`, `base_system`, `xfce4`, `virtualbox-guest`
- **Testing:** Molecule scenario verifies package install, session config, systemd target, and reboot flag.
- **Idempotency:** Safe to run repeatedly; only applies changes if not already present.
- **Security:** Uses official repositories and packages only.
- **Usage:**
  - Add the `graphical` tag to your play or role invocation to enable this feature.
  - Example:
    ```yaml
    - role: levonk.base_system.base_system
      tags: [base, system, graphical]
    ```


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

This role automatically backs up all major registry hives on Windows systems before making any registry changes, ensuring safe rollback and compliance with audit requirements.

- **Backup method:** Exports registry hives to timestamped `.reg` files in a secure backup directory
- **Tags:** `base_system`, `windows`, `registry`, `backup`
- **Testing:** Molecule scenario verifies backup file creation and integrity

## Timezone & NTP Synchronization (All OS)

This role configures the system timezone and ensures reliable network time synchronization (NTP) across all supported platforms.

- **Timezone**: Set via Ansible `timezone` module (Linux/Windows), `systemsetup` (macOS)
- **NTP Configuration**: Installs and configures NTP client/service for Linux, macOS, and Windows
- **Templates**: Uses Jinja2 templates (`ntp.conf.j2`, `macos-ntp.conf.j2`) for dynamic NTP server configuration
- **Windows**: Configures Windows Time Service and NTP peers using `w32tm` and service management
- **Idempotency**: All tasks are safe to run repeatedly; only update config if changes are needed
- **Security**: Only trusted NTP servers are used by default (Google, Cloudflare, pool.ntp.org, AWS). No scripts are executed without vetting.
- **Customization**: Override timezone and NTP servers using role variables (see below)
- **Testing**: Molecule scenario and Testinfra verify timezone, NTP service, and config file correctness

### Variables

- `timezone`: The system timezone to set (e.g., `America/Los_Angeles`). Default: OS default or inventory/group_vars
- `ntp_servers`: List of NTP servers to use (default: `["time.google.com", "time.cloudflare.com", "pool.ntp.org"]`)

#### Example usage:

```yaml
- hosts: all
  roles:
    - role: levonk.base_system.base_system
      vars:
        timezone: "America/New_York"
        ntp_servers:
          - "time.google.com"
          - "time.cloudflare.com"
          - "169.254.169.123"  # AWS Leap Smear
```

### Templates
- `ntp.conf.j2`: Used for Linux NTP configuration
- `macos-ntp.conf.j2`: Used for macOS NTP configuration
- Both templates allow dynamic server lists and advanced options

## Variables

### Variable Table Legend

- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

### Variable Reference

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| <a name="system_hostname"></a>`system_hostname` | *(unset)* | `myhost123` | string | opt-in | System hostname to set | [system/hostname.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/system/hostname.yml) |
| <a name="timezone"></a>`timezone` | *(OS default)* | `America/Los_Angeles` | string | opt-in | System timezone to set | [system/timezone.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/system/timezone.yml) |
| <a name="ntp_servers"></a>`ntp_servers` | `["time.google.com", "time.cloudflare.com", "pool.ntp.org"]` | `["time.google.com", "169.254.169.123"]` | list of string | opt-out | List of NTP servers for time sync | [system/timezone.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/system/timezone.yml) |
| <a name="base_system_install_winget"></a>`base_system_install_winget` | `true` | `false` | bool | opt-out | Install WinGet on Windows | [package-managers/chocolatey.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/package-managers/chocolatey.yml) |
| <a name="base_system_packages"></a>`base_system_packages` | `[vim, curl, wget, git, ca-certificates]` | `[vim, curl, wget, git, htop]` | list of string | opt-out | List of base packages to install | [base_packages.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/base_packages.yml), [shell_setup.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/base_system/tasks/shell_setup.yml) |

To activate a feature, set the corresponding variable in your playbook or inventory. If not set, sensible defaults are used where possible.

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: levonk.base_system.base_system
      vars:
        system_hostname: myhost123
        timezone: "America/Los_Angeles"
        ntp_servers:
          - "time.google.com"
          - "time.cloudflare.com"
        base_system_packages:
          - vim
          - curl
          - wget
          - git
          - ca-certificates
          - htop
```

- If `system_hostname` is not set, the hostname will not be changed.
- If `timezone` is not set, the system timezone will remain unchanged.
- All other features use sensible defaults and are optional.

## macOS Homebrew Installation

Homebrew is installed using a vetted script installer for maximum security and auditability. All Homebrew package management and essential package installation are handled via `tasks/package-managers/homebrew.yml`.

- **Security:** Uses `levonk.common.vet_script_installer` to vet the Homebrew install script before execution.
- **Idempotency:** Checks for Homebrew before attempting installation.
- **Packages:** Installs all `base_system_packages` via Homebrew.

## File Structure

```text
roles/base_system/
  tasks/
    main.yml
    system/
      hostname.yml
      timezone.yml
    package-managers/
      apt.yml
      yum.yml
      homebrew.yml  # All macOS Homebrew logic
      chocolatey.yml
      aur.yml
    windows/
      app-paths.yml
    base_packages.yml
    windows.yml
    fonts.yml
  molecule/
    timezone_ntp/
      converge.yml
      tests/
        test_timezone_ntp.py
  templates/
    ntp.conf.j2
    macos-ntp.conf.j2
```

## Testing

- Molecule scenario: `molecule/timezone_ntp/converge.yml` (no references to macos.yml)
- Testinfra: `molecule/timezone_ntp/tests/test_timezone_ntp.py`

## Migration Note

All macOS-specific system and package management logic is now handled in `tasks/package-managers/homebrew.yml` and `base_packages.yml`. The old `tasks/macos.yml` is deprecated and removed.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
