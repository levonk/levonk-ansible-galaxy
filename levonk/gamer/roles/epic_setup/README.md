# Ansible Role: levonk.gamer.epic_setup

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/gamer/roles/epic_setup)

Install and configure Epic Games Launcher (Windows) or Heroic Games Launcher (Linux via Flatpak) for gaming using best-practices, idempotent Ansible automation.

---

## Features & Tasks

| Feature/Task                   | Description                                                      | Required Variable(s) | Source |
|-------------------------------|------------------------------------------------------------------|----------------------|--------|
| Install Epic Games Launcher   | Installs Epic Games Launcher on Windows using common.package      | None                 | [tasks/main.yml](tasks/main.yml) |
| Install Heroic Games Launcher | Installs Heroic via Flatpak on Linux (Debian/RedHat/Ubuntu)      | None                 | [tasks/main.yml](tasks/main.yml) |
| Compliance Note               | Ensures installer is reviewed for licensing/compliance            | None                 | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Install Epic Games Launcher (Windows)

**Description:**
> Installs the Epic Games Launcher on Windows hosts using the `levonk.common.package` role for package management. Ensures only official sources are used and idempotency is maintained.

- **Supported Platforms:** Windows (all versions)
- **Tags:** `epic`, `gamer`, `package`
- **Testing:** Should be covered by Molecule scenario for Windows.
- **Idempotency:** Safe to run repeatedly; only installs if not already present.
- **Security:** Uses official package manager or trusted source.
- **Compliance:** Installer should be reviewed for licensing/compliance (see TODO in tasks).
- **Usage:**
  - No variables required by default. Override `package_name` if needed.
  - Example:
    ```yaml
    - role: levonk.gamer.epic_setup
    ```

### Install Heroic Games Launcher (Linux)

**Description:**
> Installs the Heroic Games Launcher (Epic Games alternative) on Linux hosts using Flatpak. Ensures idempotency and compliance.

- **Supported Platforms:** Debian, Ubuntu, RedHat
- **Tags:** `epic`, `gamer`, `package`, `flatpak`, `heroic`
- **Testing:** Should be covered by Molecule scenario for Linux.
- **Idempotency:** Uses `creates` to avoid duplicate installs.
- **Security:** Uses official Flatpak repo.
- **Compliance:** Installer should be reviewed for licensing/compliance (see TODO in tasks).
- **Usage:**
  - No variables required by default.
  - Example:
    ```yaml
    - role: levonk.gamer.epic_setup
    ```

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable         | Default             | Sample Value | Type    | Activation | Purpose                                   | Used In |
|-----------------|--------------------|--------------|---------|------------|-------------------------------------------|---------|
| `package_name`  | epicgameslauncher  | heroicgameslauncher | string  | opt-out    | Name of package to install (Windows only) | [tasks/main.yml](tasks/main.yml) |
| `package_state` | present            | absent       | string  | opt-out    | Desired state of Epic package (Windows)   | [tasks/main.yml](tasks/main.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Windows or Linux host (Debian, Ubuntu, RedHat)

---

### Dependencies
- `levonk.common.package` (Windows)
- Flatpak (Linux)

---

### Example Playbook
```yaml
- hosts: all
  roles:
    - role: levonk.gamer.epic_setup
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
