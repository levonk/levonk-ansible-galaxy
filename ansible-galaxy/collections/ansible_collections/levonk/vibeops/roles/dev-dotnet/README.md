# Ansible Role: levonk.vibeops.dev-dotnet

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-dotnet)

This role sets up a cross-platform .NET development environment by installing the .NET SDK on Linux and Windows. Documentation follows strict best-practices boilerplate.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-dotnet/tasks):

| Feature/Task                        | Description                              | Required Variable(s) | Source |
|--------------------------------------|------------------------------------------|----------------------|--------|
| Install .NET SDK (Linux)             | Installs .NET 6.0 SDK on Debian/RedHat/Ubuntu | N/A                 | [tasks/main.yml](tasks/main.yml) |
| Install .NET SDK (Windows)           | Installs .NET Core SDK via Chocolatey    | N/A                 | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Install .NET SDK (Linux)
**Description:** Installs the .NET 6.0 SDK using the native package manager on Debian, Ubuntu, and RedHat.
- **Supported Platforms:** Debian, Ubuntu, RedHat
- **Tags:** `dev`, `dotnet`, `.net`, `sdk`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official repositories.
- **Usage:** Enabled by default; no variables needed.

### Install .NET SDK (Windows)
**Description:** Installs the .NET Core SDK using Chocolatey on Windows.
- **Supported Platforms:** Windows
- **Tags:** `dev`, `dotnet`, `.net`, `sdk`, `windows`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official sources.
- **Usage:** Enabled by default; no variables needed.

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
- Supported platforms: Debian, Ubuntu, RedHat, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `yum` (RedHat), `chocolatey` (Windows)

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.dev-dotnet
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
