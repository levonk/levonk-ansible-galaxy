# Ansible Role: levonk.gamer.minecraft_forge_setup

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/gamer/roles/minecraft_forge_setup)

Download and (optionally) install Minecraft Forge mod loader on Windows and Linux using best-practices, idempotent Ansible automation.

---

## Features & Tasks

| Feature/Task                        | Description                                                        | Required Variable(s)                | Source |
|-------------------------------------|--------------------------------------------------------------------|-------------------------------------|--------|
| Download Forge Installer (Windows)  | Downloads Minecraft Forge installer for Windows                    | [`minecraft_forge_windows_url`](#minecraft_forge_windows_url) | [tasks/main.yml](tasks/main.yml) |
| Download Forge Installer (Linux)    | Downloads Minecraft Forge installer for Linux                      | [`minecraft_forge_linux_url`](#minecraft_forge_linux_url)     | [tasks/main.yml](tasks/main.yml) |
| Compliance Note                     | Ensures installer is reviewed for licensing/compliance             | None                                | [tasks/main.yml](tasks/main.yml) |
| (TODO) Run Installer/Verify Install | (Planned) Runs installer and verifies installation (cross-platform) | None                                | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Download Minecraft Forge Installer (Windows)

**Description:**
> Downloads the Minecraft Forge installer for Windows using the `ansible.windows.win_get_url` module. Ensures the installer is fetched from the official or trusted source.

- **Supported Platforms:** Windows (all versions)
- **Tags:** `minecraft`, `forge`, `gamer`, `installer`
- **Idempotency:** Safe to run repeatedly; downloads only if not present.
- **Security:** Uses official Forge download URLs.
- **Compliance:** Installer should be reviewed for licensing/compliance (see TODO in tasks).
- **Usage:**
  - Set `minecraft_forge_windows_url` to the desired Forge installer URL.
  - Optionally override `minecraft_forge_windows_installer_path`.
  - Example:
    ```yaml
    - role: levonk.gamer.minecraft_forge_setup
      vars:
        minecraft_forge_windows_url: "https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.exe"
    ```

### Download Minecraft Forge Installer (Linux)

**Description:**
> Downloads the Minecraft Forge installer for Linux using the `get_url` module. Ensures the installer is fetched from the official or trusted source.

- **Supported Platforms:** Debian, Ubuntu, RedHat
- **Tags:** `minecraft`, `forge`, `gamer`, `installer`
- **Idempotency:** Safe to run repeatedly; downloads only if not present.
- **Security:** Uses official Forge download URLs.
- **Compliance:** Installer should be reviewed for licensing/compliance (see TODO in tasks).
- **Usage:**
  - Set `minecraft_forge_linux_url` to the desired Forge installer URL.
  - Optionally override `minecraft_forge_linux_installer_path`.
  - Example:
    ```yaml
    - role: levonk.gamer.minecraft_forge_setup
      vars:
        minecraft_forge_linux_url: "https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.jar"
    ```

### (TODO) Run Installer and Verify Installation

**Description:**
> (Planned) Add tasks to run the Forge installer and verify installation cross-platform. Use `levonk.common.package` for Java or dependencies if needed.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable                                       | Default                              | Sample Value | Type   | Activation | Purpose                                   | Used In |
|------------------------------------------------|--------------------------------------|--------------|--------|------------|-------------------------------------------|---------|
| <a name="minecraft_forge_windows_url"></a>`minecraft_forge_windows_url` | *(unset)*                            | https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.exe | string | required | URL to Forge installer for Windows        | [tasks/main.yml](tasks/main.yml) |
| `minecraft_forge_windows_installer_path`        | C:/Temp/forge-installer.exe           | D:/Downloads/forge-installer.exe | string | opt-out    | Destination path for Windows installer    | [tasks/main.yml](tasks/main.yml) |
| <a name="minecraft_forge_linux_url"></a>`minecraft_forge_linux_url`   | *(unset)*                            | https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.jar | string | required | URL to Forge installer for Linux          | [tasks/main.yml](tasks/main.yml) |
| `minecraft_forge_linux_installer_path`          | /tmp/forge-installer.jar              | /opt/forge-installer.jar         | string | opt-out    | Destination path for Linux installer      | [tasks/main.yml](tasks/main.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Windows or Linux host (Debian, Ubuntu, RedHat)

---

### Dependencies
- None (uses built-in modules)

---

### Example Playbook
```yaml
- hosts: all
  roles:
    - role: levonk.gamer.minecraft_forge_setup
      vars:
        minecraft_forge_windows_url: "https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.exe"
        minecraft_forge_linux_url: "https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.jar"
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
