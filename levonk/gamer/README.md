# levonk.gamer Collection

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/gamer)

A collection of Ansible roles for automating the installation and configuration of popular gaming platforms and tools across Windows and Linux. Each role is designed for idempotency, compliance, and best-practices documentation.

---

## Overview

This Ansible collection provides reusable roles for setting up gaming launchers, emulators, and system tuning for optimal gaming performance. All roles are documented with variable tables, activation enums, compliance notes, and usage examples.

---

## Features & Included Content

### Roles

| Name                        | Description                                      | Major Features/Tasks                                  | Docs |
|-----------------------------|--------------------------------------------------|------------------------------------------------------|------|
| bluestacks_setup            | BlueStacks Android emulator setup (Windows)      | Install BlueStacks, compliance review                | [README](roles/bluestacks_setup/README.md) |
| epic_setup                  | Epic Games Launcher & Heroic setup               | Install Epic (Windows), Heroic via Flatpak (Linux)   | [README](roles/epic_setup/README.md) |
| game_performance_tuning     | Game performance tuning (Windows/Linux)          | Set power plan, set CPU governor                     | [README](roles/game_performance_tuning/README.md) |
| minecraft_forge_setup       | Minecraft Forge mod loader setup                 | Download Forge installer (Win/Linux), compliance     | [README](roles/minecraft_forge_setup/README.md) |
| origin_setup                | Origin client setup (Windows)                    | Install Origin, compliance review                    | [README](roles/origin_setup/README.md) |
| steam_setup                 | Steam setup (Windows/Linux)                      | Install Steam, compliance review                     | [README](roles/steam_setup/README.md) |
| xbox_setup                  | Xbox app setup (Windows)                         | Install Xbox app, compliance review                  | [README](roles/xbox_setup/README.md) |

---

## Usage

### Example: Using a Gamer Role

```yaml
- name: Setup gaming environment
  hosts: all
  collections:
    - levonk.gamer
  roles:
    - role: bluestacks_setup
    - role: epic_setup
    - role: game_performance_tuning
    - role: minecraft_forge_setup
    - role: origin_setup
    - role: steam_setup
    - role: xbox_setup
```

### Advanced Usage Patterns
- Use tags to selectively enable features (see role READMEs for tag docs)
- Override variables at play, host, or group level for flexible configuration
- Reference [role READMEs](roles/) for full variable tables, activation enums, and advanced examples

---

## Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Windows, Debian, Ubuntu, RedHat (see individual roles for details)
- Additional requirements may apply per role (see role READMEs)

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

*Document generated on: 2025-07-25*
*Version: 1.0.0*
