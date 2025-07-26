# Ansible Role: levonk.common.install_gui_conditionally

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/install_gui_conditionally)

Conditionally installs a graphical user interface (GUI) on supported systems when the `graphical` tag is specified. Supports Debian, Windows, and macOS, with idempotent and OS-specific logic.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/install_gui_conditionally/tasks):

| Feature/Task                  | Description                                                      | Required Variable(s) | Source |
|-------------------------------|------------------------------------------------------------------|----------------------|--------|
| Conditional GUI installation  | Installs GUI only if `graphical` tag is set                      | *(none)*             | [tasks/main.yml](tasks/main.yml) |
| Debian GUI install            | Installs GNOME, sets graphical.target if not already present      | *(none)*             | [tasks/Debian.yml](tasks/Debian.yml) |
| Windows GUI install           | Installs Server-Gui-Shell/Infra if not present (Core editions)   | *(none)*             | [tasks/Windows.yml](tasks/Windows.yml) |
| macOS GUI check               | Confirms GUI is always present on macOS                          | *(none)*             | [tasks/Darwin.yml](tasks/Darwin.yml) |

---

## Detailed Feature Documentation

### Conditional GUI Installation
- **Description:** Only installs GUI if the `graphical` tag is present in the run.
- **Tags:** `graphical`, `gui`, `conditional`, `crossplatform`
- **Idempotency:** Safe to run repeatedly; only installs if not already present.
- **Security:** Uses official OS package sources and modules.
- **Usage:** Run playbook with `--tags graphical`.

### Debian GUI Install
- **Description:** Installs GNOME desktop and sets graphical.target as default if not present.
- **Tags:** `gui`, `debian`, `gnome`
- **Idempotency:** Checks current systemd target and GUI presence before installing.
- **Security:** Uses apt and systemctl.

### Windows GUI Install
- **Description:** Installs Server-Gui-Shell and Management Infrastructure on Core editions if not present.
- **Tags:** `gui`, `windows`, `servercore`
- **Idempotency:** Checks for feature presence before installing.
- **Security:** Uses win_feature and PowerShell.

### macOS GUI Check
- **Description:** Confirms GUI is always present on macOS, no install needed.
- **Tags:** `gui`, `macos`
- **Usage:** No action required.

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

## Example Playbooks

```yaml
- hosts: all
  roles:
    - role: levonk.common.install_gui_conditionally
```

To run this role, use the `graphical` tag:

```bash
ansible-playbook playbook.yml --tags graphical
```

---

## Best Practices for Role Documentation
- **Document every variable** in a table with: name, default, sample, type, activation, purpose, and source link.
- **Use explicit enums** for variable activation/requirement status.
- **Link to the source** of each feature/task for transparency.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.


This role installs a graphical user interface (GUI) on a system if it doesn't have one and the `graphical` tag is specified during the Ansible run.

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: levonk.common.install_gui_conditionally
```

To run this role, use the `graphical` tag:

```bash
ansible-playbook playbook.yml --tags graphical
```
