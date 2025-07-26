# Ansible Role: levonk.hardened.harden_custom

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened/roles/harden_custom)

This role is a template for user/organization-defined custom security hardening. It allows combining baseline, moderate, and paranoid hardening levels, plus custom controls for compliance or internal policy.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened/roles/harden_custom/tasks):

| Feature/Task             | Description                                                               | Required Variable(s)              | Source |
|--------------------------|---------------------------------------------------------------------------|-----------------------------------|--------|
| Include Baseline Hardening | Imports the `harden_baseline` role for minimal baseline controls           | [`harden_custom_include_baseline`](#harden_custom_include_baseline) | [tasks/main.yml](tasks/main.yml) |
| Include Moderate Hardening | Imports the `harden_moderate` role for moderate security controls         | [`harden_custom_include_moderate`](#harden_custom_include_moderate) | [tasks/main.yml](tasks/main.yml) |
| Include Paranoid Hardening | Imports the `harden_paranoid` role for strictest security controls        | [`harden_custom_include_paranoid`](#harden_custom_include_paranoid) | [tasks/main.yml](tasks/main.yml) |
| Custom Controls           | Add user/organization-specific controls as needed                          | *(custom variables as required)*  | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Include Baseline Hardening
**Description:**
> Imports the `harden_baseline` role to apply minimal, broadly compatible security controls. Recommended as a foundation for all systems.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `baseline`, `custom`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - Enabled by default with `harden_custom_include_baseline: true`.
  - Example:
    ```yaml
    - role: levonk.hardened.harden_custom
    ```

### Include Moderate Hardening
**Description:**
> Imports the `harden_moderate` role for additional security controls beyond baseline. Use for systems requiring improved compliance or security posture.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `moderate`, `custom`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - Activate by setting `harden_custom_include_moderate: true`.
  - Example:
    ```yaml
    - role: levonk.hardened.harden_custom
      vars:
        harden_custom_include_moderate: true
    ```

### Include Paranoid Hardening
**Description:**
> Imports the `harden_paranoid` role for the strictest security controls, suitable for high-security or compliance environments.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `paranoid`, `custom`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - Activate by setting `harden_custom_include_paranoid: true`.
  - Example:
    ```yaml
    - role: levonk.hardened.harden_custom
      vars:
        harden_custom_include_paranoid: true
    ```

### Custom Controls
**Description:**
> Add your own tasks to enforce site-specific or organization-specific controls. See comments in [tasks/main.yml](tasks/main.yml) for examples.
- **Supported Platforms:** As implemented
- **Tags:** `custom`, `organization`, `hardening`
- **Idempotency:** Should be implemented as idempotent.
- **Usage:**
  - Add your own variables and controls as needed.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable                                        | Default | Sample Value | Type  | Activation | Purpose                                          | Used In |
|-------------------------------------------------|---------|--------------|-------|------------|--------------------------------------------------|---------|
| <a name="harden_custom_enable"></a>`harden_custom_enable` | true    | false        | bool  | opt-out    | Enable/disable this role                         | [vars/main.yml](vars/main.yml) |
| <a name="harden_custom_include_baseline"></a>`harden_custom_include_baseline` | true    | false        | bool  | opt-out    | Include baseline hardening controls               | [tasks/main.yml](tasks/main.yml) |
| <a name="harden_custom_include_moderate"></a>`harden_custom_include_moderate` | false   | true         | bool  | opt-in     | Include moderate hardening controls               | [tasks/main.yml](tasks/main.yml) |
| <a name="harden_custom_include_paranoid"></a>`harden_custom_include_paranoid` | false   | true         | bool  | opt-in     | Include paranoid hardening controls               | [tasks/main.yml](tasks/main.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Ubuntu, Debian, EL, Fedora, MacOSX, Windows

---

### Dependencies
- `levonk.hardened.harden_baseline` (optional, imported by default)
- `levonk.hardened.harden_moderate` (optional)
- `levonk.hardened.harden_paranoid` (optional)

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.hardened.harden_custom
```

Enable moderate and paranoid controls:
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.hardened.harden_custom
      vars:
        harden_custom_include_moderate: true
        harden_custom_include_paranoid: true
```

---

## Best Practices for Role Documentation
- **Always document every variable** in a table with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- **Link to the source** of each feature/task and variable usage for transparency and maintainability.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Reference external specs or requirements** where relevant.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new roles and features.

---

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License
Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
