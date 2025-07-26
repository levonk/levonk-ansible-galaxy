# Ansible Role: levonk.hardened.harden_moderate

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened/roles/harden_moderate)

This role applies moderate security hardening to Linux, Windows, and macOS systems. It builds on the baseline hardening by adding stricter firewall, password, and audit controls, plus OS-specific moderate security tasks. Designed for environments needing improved compliance or security posture.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened/roles/harden_moderate/tasks):

| Feature/Task                  | Description                                                | Required Variable(s)                | Source |
|-------------------------------|------------------------------------------------------------|-------------------------------------|--------|
| Apply Baseline Hardening      | Imports the `harden_baseline` role as a prerequisite       | None                                | [tasks/main.yml](tasks/main.yml) |
| Moderate Firewall Controls    | OS-specific advanced firewall configuration                | None                                | [tasks/firewall/*.yml](tasks/firewall/) |
| Moderate Password Controls    | OS-specific advanced password policy enforcement           | None                                | [tasks/pass/*.yml](tasks/pass/) |
| Moderate Audit Controls       | OS-specific audit policy and logging controls              | None                                | [tasks/audit/*.yml](tasks/audit/) |
| Moderate Extra Controls       | Additional moderate controls (per OS)                      | None                                | [tasks/extra/*.yml](tasks/extra/) |
| Moderate OS Tasks             | Moderate-level tasks for Linux, macOS, and Windows         | None                                | [tasks/linux.yml](tasks/linux.yml), [tasks/macos.yml](tasks/macos.yml), [tasks/windows.yml](tasks/windows.yml) |

---

## Detailed Feature Documentation

### Apply Baseline Hardening
**Description:**
> Always applies the `harden_baseline` role first to ensure foundational security controls are present before moderate controls are applied.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `baseline`, `moderate`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - No variables required.
  - Example:
    ```yaml
    - role: levonk.hardened.harden_moderate
    ```

### Moderate Firewall Controls
**Description:**
> Configures advanced firewall rules and policies per OS, increasing protection beyond baseline.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `firewall`, `moderate`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - No variables required.

### Moderate Password Controls
**Description:**
> Enforces stricter password policies and controls per OS, such as complexity, expiration, and lockout.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `password`, `moderate`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - No variables required.

### Moderate Audit Controls
**Description:**
> Applies enhanced audit policies, logging, and monitoring for compliance and incident response.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `audit`, `moderate`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - No variables required.

### Moderate Extra Controls
**Description:**
> Applies additional moderate controls per platform, such as extra system settings or compliance tweaks.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `extra`, `moderate`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - No variables required.

### Moderate OS Tasks
**Description:**
> OS-specific moderate security tasks for Linux, macOS, and Windows.
- **Supported Platforms:** Ubuntu, Debian, EL, Fedora, MacOSX, Windows
- **Tags:** `linux`, `macos`, `windows`, `moderate`, `hardening`
- **Idempotency:** Safe to run repeatedly.
- **Usage:**
  - No variables required.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable                                  | Default | Sample Value | Type  | Activation | Purpose                         | Used In |
|--------------------------------------------|---------|--------------|-------|------------|---------------------------------|---------|
| <a name="harden_moderate_enable"></a>`harden_moderate_enable` | true    | false        | bool  | opt-out    | Enable/disable moderate hardening | [vars/main.yml](vars/main.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Ubuntu, Debian, EL, Fedora, MacOSX, Windows

---

### Dependencies
- `levonk.hardened.harden_baseline` (imported automatically)

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.hardened.harden_moderate
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
