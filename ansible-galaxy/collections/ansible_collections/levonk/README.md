# levonk Collection

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk)

A comprehensive set of cross-platform Ansible roles for system configuration, automation, secure package/script management, user setup, hardening, and more. Designed for clarity, maintainability, and security best practices.

---

## Overview

This Ansible collection provides reusable roles for foundational system setup, secure automation, compliance, user management, gaming, hardening, and advanced developer workflows. All content is designed for maintainability, clarity, and ease of contribution.

---

## Features & Included Content

### Roles

| Name                        | Description                                 | Major Features/Tasks                                                      | Docs |
|-----------------------------|---------------------------------------------|---------------------------------------------------------------------------|------|
| base_system/base_system     | Core system configuration                   | Hostname, timezone, NTP, packages, shell, registry backup, graphical      | [README](base_system/roles/base_system/README.md) |
| base_system/user_setup      | User account, SSH/GPG key, dotfiles         | User creation, SSH/GPG keygen, chezmoi dotfiles (opt-in)                  | [README](base_system/roles/user_setup/README.md) |
| base_system/syscheck        | System integrity checks                     | SFC, diskutil, fsck, reboot flag                                          | [README](base_system/roles/syscheck/README.md) |
| base_system/reboot_manager  | Decoupled, safe system reboots              | Reboot if `reboot_required` set                                           | [README](base_system/roles/reboot_manager/README.md) |
| common/checksums            | Checksum validation for files/scripts        | Download, validate, log checksums                                         | [README](common/roles/checksums/README.md) |
| common/fonts                | Cross-platform font installation            | JetBrains Mono Nerd Font, OS-specific, fallback manual install            | [README](common/roles/fonts/README.md) |
| common/install_gui_conditionally | Conditional GUI install                | OS-specific GUI enablement, `graphical` tag                               | [README](common/roles/install_gui_conditionally/README.md) |
| common/open_firewall_port   | Open firewall ports cross-platform          | UFW, firewalld, pf, Windows Defender                                      | [README](common/roles/open_firewall_port/README.md) |
| common/package              | Secure, idempotent package management       | Unified manager, caching, checksum, cross-platform                        | [README](common/roles/package/README.md) |
| common/vet_script_installer | Secure script download/vetting/execution    | Checksum, vet tool, audit log, fail-fast                                  | [README](common/roles/vet_script_installer/README.md) |
| gamer/minecraft_forge_setup | Minecraft Forge setup                       | Download, install, validate Forge                                         | [README](gamer/roles/minecraft_forge_setup/README.md) |
| gamer/bluestacks_setup      | Bluestacks Android emulator setup           | Download, install, validate                                               | [README](gamer/roles/bluestacks_setup/README.md) |
| gamer/epic_setup            | Epic Games Launcher setup                   | Download, install, validate                                               | [README](gamer/roles/epic_setup/README.md) |
| gamer/discord_setup         | Discord setup                              | Download, install, validate                                               | [README](gamer/roles/discord_setup/README.md) |
| gamer/origin_setup          | Origin client setup                        | Download, install, validate                                               | [README](gamer/roles/origin_setup/README.md) |
| gamer/game_performance_tuning | Game performance tuning                   | System tweaks, optimization                                               | [README](gamer/roles/game_performance_tuning/README.md) |
| gamer/steam_setup           | Steam setup                                | Download, install, validate                                               | [README](gamer/roles/steam_setup/README.md) |
| gamer/xbox_setup            | Xbox app setup                             | Download, install, validate                                               | [README](gamer/roles/xbox_setup/README.md) |
| hardened/bitwarden-cli-support | Bitwarden CLI support                    | Secure secrets CLI, install                                               | [README](hardened/roles/bitwarden-cli-support/README.md) |
| hardened/harden_noop        | No-op hardening profile                    | Baseline, no-op                                                           | [README](hardened/roles/harden_noop/README.md) |
| hardened/harden_custom      | Custom hardening profile                   | User-defined                                                              | [README](hardened/roles/harden_custom/README.md) |
| hardened/harden_moderate    | Moderate hardening profile                 | CIS-like, moderate                                                        | [README](hardened/roles/harden_moderate/README.md) |
| hardened/harden_paranoid    | Paranoid hardening profile                 | Maximum lockdown                                                          | [README](hardened/roles/harden_paranoid/README.md) |
| hardened/harden_baseline    | Baseline hardening profile                 | Minimal, safe defaults                                                    | [README](hardened/roles/harden_baseline/README.md) |
| user_setup/chezmoi          | Chezmoi dotfiles manager                   | Install chezmoi, configure dotfiles                                       | [README](user_setup/roles/chezmoi/README.md) |
| user_setup/remote_user      | Remote user setup                          | Create remote user, SSH config                                            | [README](user_setup/roles/remote_user/README.md) |
| user_setup/service_user     | Service user setup                         | Create service user, systemd override                                     | [README](user_setup/roles/service_user/README.md) |
| user_setup/local_user       | Local user setup                           | Local user, password, shell                                               | [README](user_setup/roles/local_user/README.md) |
| user_setup/thick-shell      | Thick shell user profile                   | Advanced shell config                                                     | [README](user_setup/roles/thick-shell/README.md) |
| vibeops/wsl_setup           | Windows Subsystem for Linux setup          | Install WSL, configure distros                                            | [README](vibeops/roles/wsl_setup/README.md) |
| vibeops/devops              | DevOps tools and pipeline setup            | Install, configure CI/CD, tools                                           | [README](vibeops/roles/devops/README.md) |
| vibeops/dev-go              | Go development environment                 | Install Go, tools, lint, test                                             | [README](vibeops/roles/dev-go/README.md) |
| vibeops/dev-cpp             | C++ development environment                | Install compilers, tools, lint, test                                      | [README](vibeops/roles/dev-cpp/README.md) |
| vibeops/dev-ai-assisted     | AI-assisted dev tools                      | Install Copilot, TabNine, etc.                                            | [README](vibeops/roles/dev-ai-assisted/README.md) |
| vibeops/dev-rust            | Rust development environment               | Install Rust, tools, lint, test                                           | [README](vibeops/roles/dev-rust/README.md) |
| vibeops/browsers            | Browser setup                             | Install browsers, extensions                                              | [README](vibeops/roles/browsers/README.md) |
| vibeops/quantified-self     | Quantified self tools                      | Install self-tracking tools                                               | [README](vibeops/roles/quantified-self/README.md) |
| vibeops/dev-ruby            | Ruby development environment               | Install Ruby, tools, lint, test                                           | [README](vibeops/roles/dev-ruby/README.md) |
| vibeops/comms               | Communication tools                        | Install chat, mail, video tools                                           | [README](vibeops/roles/comms/README.md) |
| vibeops/dev-java            | Java development environment               | Install Java, tools, lint, test                                           | [README](vibeops/roles/dev-java/README.md) |
| vibeops/dev-dotnet          | .NET development environment               | Install .NET, tools, lint, test                                           | [README](vibeops/roles/dev-dotnet/README.md) |
| vibeops/dev-docker          | Docker and container tools                 | Install Docker, Compose, tools                                            | [README](vibeops/roles/dev-docker/README.md) |
| vibeops/dev-ansible         | Ansible development tools                  | Install ansible, plugins, lint                                            | [README](vibeops/roles/dev-ansible/README.md) |
| vibeops/dev-js              | JavaScript/Node.js environment             | Install Node.js, npm, yarn, tools                                         | [README](vibeops/roles/dev-js/README.md) |
| vibeops/tools               | General developer tools                    | Install editors, utilities                                                | [README](vibeops/roles/tools/README.md) |
| vibeops/dev-python          | Python development environment             | Install Python, pip, venv, tools                                          | [README](vibeops/roles/dev-python/README.md) |
| vibeops/developer           | General developer environment              | IDEs, SDKs, helpers                                                       | [README](vibeops/roles/developer/README.md) |
| vibeops/dev-php             | PHP development environment                | Install PHP, tools, lint, test                                            | [README](vibeops/roles/dev-php/README.md) |
| vibeops/knowledge           | Knowledge management tools                 | Install note-taking, management tools                                     | [README](vibeops/roles/knowledge/README.md) |
| vibeops/multimedia          | Multimedia tools                           | Install audio/video/photo editors                                         | [README](vibeops/roles/multimedia/README.md) |

---

## Usage

### Example: Using Multiple Roles

```yaml
- hosts: all
  collections:
    - levonk
  roles:
    - base_system/base_system
    - common/package
    - gamer/steam_setup
    - hardened/harden_baseline
    - user_setup/chezmoi
    - vibeops/devops
  vars:
    system_hostname: myhost
    timezone: "America/Los_Angeles"
    base_system_packages:
      - vim
      - curl
      - git
```

### Advanced Usage Patterns
- Use tags to selectively enable features (see role READMEs for tag docs)
- Override variables at play, host, or group level for flexible configuration
- Reference [role READMEs](common/roles/) for full variable tables, activation enums, and advanced examples

---

## Requirements

- Ansible 2.9+
- Python 3.6+
- Supported platforms: Linux, macOS, Windows (see individual roles for details)
- Additional requirements may apply per role/module

---

## Testing

- Molecule scenarios: see `roles/<role>/molecule/`
- ansible-test: `ansible-test integration`
- Linting: `ansible-lint`

```bash
# Install test requirements
pip install -r requirements-test.txt

# Run tests
ansible-test integration
```

---

## Best Practices for Collection Maintenance

- **Document every variable and parameter** in included roles using tables with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- **Link to the source** of each feature/task and variable usage for transparency and maintainability.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Reference external specs or requirements** where relevant.
- **Keep this README and all role/module docs up to date** as the collection evolves.
- **Encourage contributors** to follow these conventions for all new roles, modules, and features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update documentation for any new features, roles, or modules. See individual role READMEs for detailed contribution guidelines.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
