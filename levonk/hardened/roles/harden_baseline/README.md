# Ansible Role: levonk.hardened.harden_baseline

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened/roles/harden_baseline)

Minimal baseline security hardening for Linux, Windows, and macOS. Provides foundational security controls, safe scripting, configuration audit, and optional secure VPN (Cloudflare WARP). Designed for clarity, idempotency, and compliance.

---

## Features & Tasks

| Feature/Task                        | Description                                                    | Required Variable(s)                        | Source |
|------------------------------------- |----------------------------------------------------------------|---------------------------------------------|--------|
| Linux baseline hardening             | Installs shellcheck, bat, gnupg, vet, audits config, GPG setup | None                                        | [tasks/linux.yml](tasks/linux.yml) |
| Windows baseline hardening           | Enables firewall, disables Guest, GPG setup                    | None                                        | [tasks/windows.yml](tasks/windows.yml) |
| macOS baseline hardening             | Enables firewall, installs gnupg/pinentry-mac, GPG setup       | None                                        | [tasks/macos.yml](tasks/macos.yml) |
| Cloudflare WARP VPN (CLI/GUI)        | Installs, registers, and connects WARP VPN (CLI/GUI)           | `harden_baseline_install_warp_cli`, `harden_baseline_install_warp_gui` | [tasks/warp.yml](tasks/warp.yml) |
| Secure scripting vetting             | Installs and uses `vet` to check scripts before execution      | None                                        | [tasks/linux.yml](tasks/linux.yml) |
| Configuration auditing (Linux)       | Installs and configures etckeeper for /etc versioning          | None                                        | [tasks/etckeeper.yml](tasks/etckeeper.yml) |

---

## Detailed Feature Documentation

### Linux Baseline Hardening
- Installs `shellcheck`, `bat`, `gnupg`, and `vet` for secure scripting and shell auditing.
- Sets up GPG keys for automation, exports public keys.
- Downloads and vets Oh My Zsh installer script.
- Installs and configures `etckeeper` for `/etc` version control.

### Windows Baseline Hardening
- Enables Windows firewall.
- Installs GPG via Chocolatey, sets up GPG keys.
- Disables Guest account for security.

### macOS Baseline Hardening
- Enables macOS firewall.
- Installs `gnupg` and `pinentry-mac`, configures GPG agent.
- Sets up GPG keys for automation.

### Cloudflare WARP VPN
- Installs Cloudflare WARP CLI (Linux/Windows) and optionally GUI.
- Registers and connects client, ensures secure DNS/VPN.
- Controlled by `harden_baseline_install_warp_cli` and `harden_baseline_install_warp_gui` variables.

### Secure Scripting Vetting
- Installs `vet` and uses it to check downloaded scripts before execution (avoids `curl | sh` anti-pattern).

### Configuration Auditing (Linux)
- Installs and configures `etckeeper` to track changes in `/etc` via git.

---

## Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable                           | Default | Sample Value | Type    | Activation | Purpose                                        | Used In |
|------------------------------------ |---------|--------------|---------|------------|------------------------------------------------|---------|
| `harden_baseline_enable`           | true    | false        | bool    | opt-out    | Enable/disable baseline hardening              | [vars/main.yml](vars/main.yml) |
| `harden_baseline_install_warp_cli` | true    | false        | bool    | opt-out    | Install Cloudflare WARP CLI                    | [defaults/main.yml](defaults/main.yml), [tasks/warp.yml](tasks/warp.yml) |
| `harden_baseline_install_warp_gui` | false   | true         | bool    | opt-in     | Install Cloudflare WARP GUI (graphical only)   | [defaults/main.yml](defaults/main.yml), [tasks/warp.yml](tasks/warp.yml) |

---

## Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- Root/sudo privileges required for system changes

---

## Dependencies
- `levonk.common.package` (recommended for package management)

---

## Example Playbook
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.hardened.harden_baseline
```

To install with WARP GUI (requires graphical environment):
```yaml
- hosts: workstations
  become: yes
  vars:
    harden_baseline_install_warp_gui: true
  roles:
    - role: levonk.hardened.harden_baseline
  tags:
    - graphical
```

---

## Best Practices for Role Documentation
- Document every variable in a table with name, default, sample, type, activation, purpose, and source link.
- Use explicit enums for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- Link to the source of each feature/task and variable usage for transparency and maintainability.
- Provide usage examples for all major features and variable combinations.
- Document tags and advanced usage patterns for selective feature activation.
- Include explicit notes on idempotency and security for each feature.
- Reference external specs or requirements where relevant.
- Keep README.md up to date as the role evolves.
- Encourage contributors to follow this template for all new roles and features.

---

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License
Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
