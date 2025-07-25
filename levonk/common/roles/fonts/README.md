# Ansible Role: levonk.common.fonts

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/fonts)

Automates installation of JetBrains Mono Nerd Font across Windows, macOS, and Debian-based Linux, ensuring modern terminal and editor glyph support for all users.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/fonts/tasks):

| Feature/Task                           | Description                                                       | Required Variable(s) | Source |
|----------------------------------------|-------------------------------------------------------------------|----------------------|--------|
| Install JetBrains Mono Nerd Font       | Installs font on all supported platforms                          | *(none)*             | [tasks/jetbrains-monofont.yml](tasks/jetbrains-monofont.yml) |
| Ensure font dependencies (Debian)      | Installs unzip, fontconfig for font install                       | *(none)*             | [tasks/jetbrains-monofont.yml](tasks/jetbrains-monofont.yml) |
| Install via Homebrew Cask (macOS)      | Uses Homebrew cask to install font                                | *(none)*             | [tasks/jetbrains-monofont.yml](tasks/jetbrains-monofont.yml) |
| Install via Winget (Windows)           | Uses Winget to install font                                       | *(none)*             | [tasks/jetbrains-monofont.yml](tasks/jetbrains-monofont.yml) |
| Manual download/install fallback       | Downloads and unzips latest font release if not in package manager| *(none)*             | [tasks/jetbrains-monofont.yml](tasks/jetbrains-monofont.yml) |
| Rebuild font cache (Debian)            | Ensures fonts are available system-wide                           | *(none)*             | [tasks/jetbrains-monofont.yml](tasks/jetbrains-monofont.yml) |

---

## Detailed Feature Documentation

### Install JetBrains Mono Nerd Font
- **Description:** Installs the latest JetBrains Mono Nerd Font on all platforms using the best available method.
- **Tags:** `fonts`, `jetbrains`, `nerd-font`, `crossplatform`
- **Idempotency:** Safe to run repeatedly; only installs if not present or outdated.
- **Security:** Uses official package sources or GitHub releases.
- **Usage:** No variables required.

### Ensure Font Dependencies (Debian)
- **Description:** Installs `unzip` and `fontconfig` for font installation.
- **Tags:** `fonts`, `dependencies`, `debian`
- **Idempotency:** Installs only if missing.
- **Security:** Uses OS package manager.

### Install via Homebrew Cask (macOS)
- **Description:** Installs font using Homebrew cask.
- **Tags:** `fonts`, `macos`, `homebrew`
- **Idempotency:** Only installs if not present.
- **Security:** Uses trusted Homebrew tap.

### Install via Winget (Windows)
- **Description:** Installs font using Winget.
- **Tags:** `fonts`, `windows`, `winget`
- **Idempotency:** Only installs if not present.
- **Security:** Uses trusted Winget source.

### Manual Download/Install Fallback (Debian)
- **Description:** Downloads and installs latest font release from GitHub if not in package manager.
- **Tags:** `fonts`, `debian`, `manual`, `fallback`
- **Idempotency:** Only downloads/installs if not already present.
- **Security:** Uses official GitHub releases.

### Rebuild Font Cache (Debian)
- **Description:** Rebuilds the font cache so new fonts are available system-wide.
- **Tags:** `fonts`, `debian`, `fontconfig`
- **Idempotency:** Always safe to run.

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
  roles:
    - role: levonk.common.fonts
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

