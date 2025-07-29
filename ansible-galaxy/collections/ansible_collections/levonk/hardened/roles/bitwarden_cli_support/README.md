# Ansible Role: levonk.hardened.bitwarden-cli-support

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/hardened/roles/bitwarden-cli-support)

Install and manage Bitwarden CLI tools (`bw`, `bws`, `rbw`) in a secure, OS-portable, and compliance-ready way. Supports official Bitwarden CLI, Bitwarden Secrets CLI, and the Rust Bitwarden CLI. Modular, idempotent, and suitable for pipelines and compliance automation.

---

## Features & Tasks

| Feature/Task                | Description                                                  | Required Variable(s) | Source |
|-----------------------------|--------------------------------------------------------------|----------------------|--------|
| Install Bitwarden CLI (bw)  | Installs official Bitwarden CLI (`bw`) on Debian/Unix        | None                 | [tasks/bw.yml](tasks/bw.yml) |
| Install Bitwarden Secrets CLI (bws) | Installs Bitwarden Secrets CLI (`bws`) on Debian/Unix | None | [tasks/bws.yml](tasks/bws.yml) |
| Install Rust Bitwarden CLI (rbw) | Installs Rust Bitwarden CLI (`rbw`) on Debian/Unix     | None | [tasks/rbw.yml](tasks/rbw.yml) |
| OS-specific logic           | Includes platform-specific tasks for Debian, Windows, Darwin | None                 | [tasks/main.yml](tasks/main.yml) |
| Compliance Note             | Ensures all downloads use HTTPS and official sources         | None                 | [tasks/*] |

---

## Detailed Feature Documentation

### Install Bitwarden CLI (bw)
**Description:**
> Installs the official Bitwarden CLI (`bw`) on Debian-based systems using `levonk.common.package` if available, or securely downloads from Bitwarden if not. Used for vault access, automation, and scripting.
- **Supported Platforms:** Debian/Ubuntu (Linux)
- **Tags:** `bitwarden`, `cli`, `security`, `hardened`
- **Idempotency:** Safe to run repeatedly; only installs if not present.
- **Security:** Uses package manager or HTTPS download from official Bitwarden.
- **Usage:**
  - No variables required by default.
  - Example:
    ```yaml
    - role: levonk.hardened.bitwarden-cli-support
    ```

### Install Bitwarden Secrets CLI (bws)
**Description:**
> Installs Bitwarden Secrets CLI (`bws`) for managing secrets in automation/CI. Uses `levonk.common.package` or secure HTTPS download.
- **Supported Platforms:** Debian/Ubuntu (Linux)
- **Tags:** `bitwarden`, `bws`, `secrets`, `cli`, `hardened`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses package manager or HTTPS download from official Bitwarden.

### Install Rust Bitwarden CLI (rbw)
**Description:**
> Installs the Rust Bitwarden CLI (`rbw`), a fast and scriptable alternative, using `levonk.common.package` or the latest GitHub release.
- **Supported Platforms:** Debian/Ubuntu (Linux)
- **Tags:** `bitwarden`, `rbw`, `rust`, `cli`, `hardened`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses package manager or HTTPS download from GitHub releases.

### OS-specific logic
- **Windows/macOS:** Not yet implemented (emits debug message).
- **Unsupported OS:** Fails gracefully with an error message.

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
- Debian/Ubuntu (Linux); Windows/macOS planned

---

### Dependencies
- `levonk.common.package` (recommended for package management)

---

### Example Playbook
```yaml
- hosts: all
  roles:
    - role: levonk.hardened.bitwarden-cli-support
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
