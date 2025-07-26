# Ansible Role: levonk.vibeops.developer

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/developer)

This role configures a cross-platform developer environment with essential tools and settings for productivity and consistency. Documentation follows strict best-practices boilerplate.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/developer/tasks):

| Feature/Task                  | Description                                  | Required Variable(s) | Source |
|-------------------------------|----------------------------------------------|----------------------|--------|
| OS-specific configuration     | Applies developer settings per OS            | N/A                 | [tasks/Darwin.yml](tasks/Darwin.yml), [tasks/Debian.yml](tasks/Debian.yml), [tasks/Windows.yml](tasks/Windows.yml) |
| Install Universal Ctags       | Installs universal-ctags tool                | N/A                 | [tasks/install_universal_ctags.yml](tasks/install_universal_ctags.yml) |
| Install Super Linter          | Installs super-linter (npm or package)       | N/A                 | [tasks/install_super_linter.yml](tasks/install_super_linter.yml) |
| Install yq YAML processor     | Installs yq for YAML processing              | N/A                 | [tasks/install_yq.yml](tasks/install_yq.yml) |
| Install yamlfmt YAML formatter| Installs yamlfmt for YAML formatting         | Go must be installed | [tasks/install_yamlfmt.yml](tasks/install_yamlfmt.yml) |

---

## Detailed Feature Documentation

### OS-specific configuration
**Description:** Applies developer settings for Windows, Debian/Ubuntu, or macOS.
- **Supported Platforms:** Windows, Debian, Ubuntu, macOS
- **Tags:** `developer`, `settings`, `os`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Modifies only safe system/user settings.
- **Usage:** Enabled by default; no variables needed.

### Install Universal Ctags
**Description:** Installs universal-ctags for code navigation.
- **Supported Platforms:** All
- **Tags:** `developer`, `tools`, `ctags`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses package manager.
- **Usage:** Enabled by default; no variables needed.

### Install Super Linter
**Description:** Installs super-linter using package manager or npm.
- **Supported Platforms:** All
- **Tags:** `developer`, `tools`, `linter`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses package manager or npm.
- **Usage:** Enabled by default; no variables needed.

### Install yq YAML processor
**Description:** Installs yq for YAML processing.
- **Supported Platforms:** All
- **Tags:** `developer`, `tools`, `yq`, `yaml`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses package manager.
- **Usage:** Enabled by default; no variables needed.

### Install yamlfmt YAML formatter
**Description:** Installs yamlfmt for YAML formatting (requires Go pre-installed).
- **Supported Platforms:** All
- **Tags:** `developer`, `tools`, `yamlfmt`, `yaml`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official Go install method.
- **Usage:** Requires Go to be installed first.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

---

#### Variable Reference

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| *(none by default)* |         |              |      |            |         |         |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `chocolatey` (Windows), `brew` (macOS)
- Go must be installed for yamlfmt
- npm must be installed for super-linter fallback

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.developer
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

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the MIT License. See LICENSE file in the project root for full license information.
