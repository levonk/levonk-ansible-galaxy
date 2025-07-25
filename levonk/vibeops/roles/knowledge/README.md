# Ansible Role: levonk.vibeops.knowledge

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/knowledge)

This role provisions cross-platform knowledge management tools, including Obsidian and Microsoft Copilot, using native package managers and best-practices Ansible role structure.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/knowledge/tasks):

| Feature/Task                | Description                                 | Required Variable(s)                  | Source |
|-----------------------------|---------------------------------------------|---------------------------------------|--------|
| Install Obsidian            | Installs Obsidian knowledge management app  | `knowledge_install_obsidian`          | [tasks/obsidian.yml](tasks/obsidian.yml) |
| Install Microsoft Copilot   | Installs Microsoft Copilot (Windows only)   | `knowledge_install_microsoft_copilot` | [tasks/microsoft_copilot.yml](tasks/microsoft_copilot.yml) |

---

## Detailed Feature Documentation

### Install Obsidian
**Description:** Installs Obsidian on Windows (via package), macOS (via package), and Debian (via latest .deb from GitHub Releases). Controlled by `knowledge_install_obsidian` (opt-in, default false) and requires the `graphical` tag.
- **Supported Platforms:** Windows, macOS, Debian
- **Tags:** `knowledge`, `obsidian`, `productivity`, `graphical`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official sources or GitHub releases.
- **Usage:** Set `knowledge_install_obsidian: true` and run with `graphical` tag.

### Install Microsoft Copilot
**Description:** Installs Microsoft Copilot on Windows (via package). Controlled by `knowledge_install_microsoft_copilot` (opt-in, default false) and requires the `graphical` tag.
- **Supported Platforms:** Windows
- **Tags:** `knowledge`, `copilot`, `productivity`, `graphical`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official sources.
- **Usage:** Set `knowledge_install_microsoft_copilot: true` and run with `graphical` tag.

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

| Variable                           | Default | Sample Value | Type  | Activation | Purpose                                 | Used In |
|-------------------------------------|---------|--------------|-------|------------|-----------------------------------------|---------|
| `knowledge_install_obsidian`        | `false` | `true`       | bool  | opt-in     | Installs Obsidian knowledge manager     | [tasks/obsidian.yml](tasks/obsidian.yml) |
| `knowledge_install_microsoft_copilot` | `false` | `true`    | bool  | opt-in     | Installs Microsoft Copilot (Windows)    | [tasks/microsoft_copilot.yml](tasks/microsoft_copilot.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Windows, macOS, Debian
- Platform-specific: `winget` (Windows), `apt` (Debian), `homebrew` (macOS)
- `graphical` tag must be set for any installation

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  vars:
    knowledge_install_obsidian: true
    knowledge_install_microsoft_copilot: false
  roles:
    - role: levonk.vibeops.knowledge
      tags: ["graphical"]
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
