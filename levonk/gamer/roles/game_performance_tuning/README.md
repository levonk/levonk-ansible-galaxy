# Ansible Role: levonk.gamer.game_performance_tuning

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/gamer/roles/game_performance_tuning)

Optimize system settings for maximum gaming performance on Windows and Linux using best-practices, idempotent Ansible automation.

---

## Features & Tasks

| Feature/Task                        | Description                                             | Required Variable(s) | Source |
|-------------------------------------|---------------------------------------------------------|----------------------|--------|
| Set High Performance Power Profile  | Sets Windows power plan to "High performance"           | None                 | [tasks/main.yml](tasks/main.yml) |
| Set CPU Governor to Performance     | Sets Linux CPU governor to "performance"                | None                 | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Set High Performance Power Profile (Windows)

**Description:**
> Sets the Windows power plan to "High performance" using the `ansible.windows.win_power_plan` module. Improves CPU responsiveness and overall gaming performance.

- **Supported Platforms:** Windows (all versions)
- **Tags:** `gamer`, `performance`, `windows`
- **Idempotency:** Safe to run repeatedly; only applies if not already set.
- **Security:** Uses official Windows APIs.
- **Usage:**
  - No variables required by default.
  - Example:
    ```yaml
    - role: levonk.gamer.game_performance_tuning
    ```

### Set CPU Governor to Performance (Linux)

**Description:**
> Sets the CPU frequency governor to "performance" on Linux systems using the `cpupower` utility for maximum CPU speed during gaming.

- **Supported Platforms:** Debian, Ubuntu, RedHat
- **Tags:** `gamer`, `performance`, `linux`
- **Idempotency:** Uses command with `frequency-set -g performance`. Only applies if not already set.
- **Security:** Requires root privileges.
- **Usage:**
  - No variables required by default.
  - Example:
    ```yaml
    - role: levonk.gamer.game_performance_tuning
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

| Variable         | Default | Sample Value | Type   | Activation | Purpose                          | Used In |
|-----------------|---------|--------------|--------|------------|----------------------------------|---------|
| *(none required)*|         |              |        |            |                                  |         |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Windows or Linux host (Debian, Ubuntu, RedHat)
- `cpupower` utility installed on Linux for CPU governor change

---

### Dependencies
- None (uses built-in modules and standard utilities)

---

### Example Playbook
```yaml
- hosts: all
  roles:
    - role: levonk.gamer.game_performance_tuning
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
