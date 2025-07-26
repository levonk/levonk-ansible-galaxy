# Ansible Role: levonk.gamer.origin_setup

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/gamer/roles/origin_setup)

Install and configure Origin (Windows) for gaming using best-practices, idempotent Ansible automation.

---

## Features & Tasks

| Feature/Task                   | Description                                                      | Required Variable(s) | Source |
|-------------------------------|------------------------------------------------------------------|----------------------|--------|
| Install Origin (Windows)      | Installs Origin on Windows using levonk.common.package            | None                 | [tasks/main.yml](tasks/main.yml) |
| Compliance Note               | Ensures installer is reviewed for licensing/compliance            | None                 | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Install Origin (Windows)

**Description:**
> Installs the Origin client on Windows hosts using the `levonk.common.package` role for package management. Ensures only official sources are used and idempotency is maintained.

- **Supported Platforms:** Windows (all versions)
- **Tags:** `origin`, `gamer`, `package`
- **Idempotency:** Safe to run repeatedly; only installs if not already present.
- **Security:** Uses official package manager or trusted source.
- **Compliance:** Installer should be reviewed for licensing/compliance (see TODO in tasks).
- **Usage:**
  - No variables required by default. Override `package_name` if needed.
  - Example:
    ```yaml
    - role: levonk.gamer.origin_setup
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

| Variable         | Default | Sample Value | Type    | Activation | Purpose                                   | Used In |
|-----------------|---------|--------------|---------|------------|-------------------------------------------|---------|
| `package_name`  | origin  | origin_beta  | string  | opt-out    | Name of package to install (Windows only) | [tasks/main.yml](tasks/main.yml) |
| `package_state` | present | absent       | string  | opt-out    | Desired state of Origin package           | [tasks/main.yml](tasks/main.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Windows host

---

### Dependencies
- `levonk.common.package` (Windows)

---

### Example Playbook
```yaml
- hosts: all
  roles:
    - role: levonk.gamer.origin_setup
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
