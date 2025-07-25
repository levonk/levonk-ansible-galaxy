# Ansible Role: levonk.hardened.harden_noop

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened/roles/harden_noop)

A no-op hardening role for test pipelines, compatibility, and baseline playbook validation. This role performs no actions and is safe to apply to any platform.

---

## Features & Tasks

| Feature/Task                       | Description                                               | Required Variable(s) | Source |
|------------------------------------|-----------------------------------------------------------|----------------------|--------|
| No hardening performed (noop)      | Emits a debug message; no system changes are made         | None                 | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### No hardening performed (noop)

**Description:**
> This role emits a debug message and performs no hardening actions. It is intended for pipeline testing, playbook compatibility, and as a baseline for role inclusion/exclusion logic.

- **Supported Platforms:** Windows, MacOS, Ubuntu, Debian, EL, Fedora (all)
- **Tags:** `hardening`, `noop`, `security`
- **Idempotency:** Safe to run repeatedly; no changes are made.
- **Security:** No effect on system security posture.
- **Usage:**
  - No variables required by default.
  - Example:
    ```yaml
    - role: levonk.hardened.harden_noop
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
- Any supported platform (see meta)

---

### Dependencies
- None

---

### Example Playbook
```yaml
- hosts: all
  roles:
    - role: levonk.hardened.harden_noop
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
