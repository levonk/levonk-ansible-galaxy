# Ansible Role: syscheck

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/base_system/roles/syscheck)

A cross-platform, asynchronous system integrity check role for Windows, macOS, and Linux. Schedules or runs checks in a non-blocking way and can trigger a reboot if required (Linux).

---

## Features & Tasks

| Feature/Task                | Description                                                                 | Required Variable(s) | Source |
|-----------------------------|-----------------------------------------------------------------------------|----------------------|--------|
| Windows File Checker        | Runs `sfc /scannow` asynchronously on Windows                               | None                 | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/syscheck/tasks/main.yml) |
| macOS Volume Verify         | Runs `diskutil verifyVolume /` asynchronously on macOS                      | None                 | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/syscheck/tasks/main.yml) |
| Linux Filesystem Check      | Schedules fsck on next reboot by touching `/forcefsck` (Debian/RedHat)      | None                 | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/syscheck/tasks/main.yml) |
| Set Reboot Required (Linux) | Sets `reboot_required: true` if fsck is scheduled (for use by reboot_manager)| None                 | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/syscheck/tasks/main.yml) |

---

## Detailed Feature Documentation

### Windows File Checker
- **Description:** Runs System File Checker (`sfc /scannow`) asynchronously.
- **Tags:** `syscheck`, `windows`
- **Idempotency:** Safe to run repeatedly; SFC only repairs if needed.
- **Security:** Uses trusted Windows SFC utility.
- **Usage:** No variables required; runs automatically on Windows.

### macOS Volume Verify
- **Description:** Runs `diskutil verifyVolume /` asynchronously.
- **Tags:** `syscheck`, `macos`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses trusted Apple utility.
- **Usage:** No variables required; runs automatically on macOS.

### Linux Filesystem Check
- **Description:** Schedules fsck on next reboot by touching `/forcefsck`.
- **Tags:** `syscheck`, `linux`, `fsck`
- **Idempotency:** File is only touched if not present.
- **Security:** No scripts executed; only creates marker file.
- **Usage:** No variables required; runs automatically on Debian/RedHat.
- **Testing:** Can check for `/forcefsck` file presence after role run.

### Set Reboot Required (Linux)
- **Description:** Sets `reboot_required: true` if fsck is scheduled, for use by a decoupled reboot manager role.
- **Tags:** `syscheck`, `linux`, `reboot`
- **Usage:** Integrate with a reboot manager role to handle reboots as needed.

---

## Variables

### Variable Table Legend

- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

### Variable Reference

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| *(none)* |         |              |      |            |         |         |

---

## Example Playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: levonk.base_system.syscheck
    - role: levonk.base_system.reboot_manager  # Handles reboot if scheduled
```

---

## Best Practices for Role Documentation

- **Document every variable** in a table with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status.
- **Link to the source** of each feature/task for transparency.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new roles and features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
