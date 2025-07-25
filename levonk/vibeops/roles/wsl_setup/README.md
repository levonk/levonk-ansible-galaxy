# Ansible Role: levonk.vibeops.wsl_setup

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/wsl_setup)

This role installs Windows Subsystem for Linux (WSL2) and a specified Linux distribution on Windows systems, following best-practices for idempotency and security.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/wsl_setup/tasks):

| Feature/Task | Description | Required Variable(s) | Source |
|--------------|-------------|----------------------|--------|
| Enable WSL2 and Virtual Machine Platform | Installs required Windows features for WSL2 | None | [tasks/main.yml](tasks/main.yml) |
| Set WSL2 as default | Sets WSL2 as the default version for new distros | None | [tasks/main.yml](tasks/main.yml) |
| Install Linux distribution | Installs the specified Linux distribution (default: Debian) | [`wsl_distribution`](#wsl_distribution) | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Enable WSL2 and Virtual Machine Platform

**Description:**
> Enables the required Windows features to support WSL2, including Windows Subsystem for Linux and Virtual Machine Platform.

- **Supported Platforms:** Windows (all versions)
- **Tags:** `wsl`, `wsl2`, `windows`, `virtualmachineplatform`
- **Testing:** Manual and Molecule scenario tests for feature enablement and idempotency.
- **Idempotency:** Safe to run repeatedly; only applies changes if features are not already enabled.
- **Security:** Uses only official Windows features.
- **Usage:**
  - No variables required. Always runs on Windows.

### Set WSL2 as Default

**Description:**
> Sets WSL2 as the default version for new Linux distributions installed via WSL.

- **Supported Platforms:** Windows (all versions)
- **Tags:** `wsl`, `wsl2`, `windows`
- **Testing:** Manual verification; idempotent command.
- **Idempotency:** Command is safe to run repeatedly.
- **Security:** Uses only official Windows command-line tools.
- **Usage:**
  - No variables required.

### Install Linux Distribution

**Description:**
> Installs the specified Linux distribution (default: Debian) via WSL. Can be customized by setting the `wsl_distribution` variable.

- **Supported Platforms:** Windows (all versions)
- **Tags:** `wsl`, `wsl2`, `debian`, `windows`, `distribution`
- **Testing:** Manual and Molecule scenario tests for distribution installation.
- **Idempotency:** Only installs if the distribution is not already present.
- **Security:** Uses official Microsoft WSL installation mechanisms.
- **Usage:**
  - Set the `wsl_distribution` variable to the desired distribution name (e.g., `Ubuntu`, `Debian`).
  - Example:
    ```yaml
    - role: levonk.vibeops.wsl_setup
      vars:
        wsl_distribution: Ubuntu
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

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| <a name="wsl_distribution"></a>`wsl_distribution` | `Debian` | `Ubuntu` | string | opt-out | Specifies which Linux distribution to install | [tasks/main.yml](tasks/main.yml) |

---

### Requirements

- Ansible 2.9+
- Windows host

---

### Dependencies

None

---

### Example Playbook

```yaml
- hosts: windows
  roles:
    - role: levonk.vibeops.wsl_setup
      vars:
        wsl_distribution: Ubuntu
```

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 Brillarc, LLC. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
