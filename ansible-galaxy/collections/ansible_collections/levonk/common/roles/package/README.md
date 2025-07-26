# Ansible Role: levonk.common.package

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/package)

A secure, cross-platform, idempotent Ansible role for package management. Supports Windows (WinGet/Chocolatey), macOS (Homebrew), Linux (apt/yum/dnf/zypper), and more. Handles repo/tool installation, upgrades, stateful caching, and post-install verification.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/package/tasks):

| Feature/Task                  | Description                                                  | Required Variable(s)                | Source |
|-------------------------------|--------------------------------------------------------------|-------------------------------------|--------|
| Detect platform               | Determines OS and includes platform-specific logic           | *(none)*                            | [tasks/main.yml](tasks/main.yml) |
| Platform-specific install     | Installs, upgrades, or removes packages using best provider  | [`name`](#name)                     | [tasks/platform/*.yml](tasks/main.yml) |
| Stateful caching              | Uses JSON cache to avoid redundant installs/upgrades         | [`levonk_package_cache_file`](#levonk_package_cache_file) | [tasks/main.yml](tasks/main.yml) |
| Checksum validation           | Validates installer checksum if provided                     | [`checksum`](#checksum), [`checksum_url`](#checksum_url) | [tasks/main.yml](tasks/main.yml) |
| Update cache expiry           | Controls cache freshness window                              | [`levonk_package_cache_expiry_minutes`](#levonk_package_cache_expiry_minutes) | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Detect Platform
- **Description:** Determines the current OS and includes the relevant platform-specific tasks.
- **Supported Platforms:** Windows, macOS, Linux (Debian, RedHat, etc.)
- **Tags:** `package`, `crossplatform`, `detection`
- **Idempotency:** Always safe to run.
- **Security:** No side effects.

### Platform-specific Install
- **Description:** Installs, upgrades, or removes packages using the best available provider (apt, yum, dnf, zypper, brew, choco, winget, etc.).
- **Tags:** `package`, `install`, `upgrade`, `remove`, `crossplatform`
- **Idempotency:** Only installs/upgrades if needed.
- **Security:** Uses official package managers and modules.
- **Usage:** Set required variables (see below).

### Stateful Caching
- **Description:** Uses a JSON cache file to avoid redundant installs/upgrades.
- **Tags:** `package`, `cache`, `stateful`
- **Idempotency:** Avoids unnecessary operations if cache is fresh.
- **Security:** Cache file path is user-configurable.

### Checksum Validation
- **Description:** Validates installer checksum if provided, using explicit value or URL.
- **Tags:** `package`, `checksum`, `security`
- **Idempotency:** Only validates if checksum/checksum_url is set.
- **Security:** Prevents installation of tampered packages.

### Update Cache Expiry
- **Description:** Controls how long the cache is considered fresh before re-checking.
- **Tags:** `package`, `cache`, `expiry`
- **Idempotency:** Safe to run repeatedly.
- **Security:** User-configurable.

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
| <a name="name"></a>`name` | *(unset)* | `curl` | string/list | required | Package name(s) to install/upgrade/remove | [defaults/main.yml](defaults/main.yml) |
| <a name="state"></a>`state` | `present` | `latest` | string | opt-out | Desired package state (present/latest/absent) | [defaults/main.yml](defaults/main.yml) |
| <a name="update_cache"></a>`update_cache` | `false` | `true` | bool | opt-in | Force update/upgrade of package lists | [defaults/main.yml](defaults/main.yml) |
| <a name="checksum"></a>`checksum` | *(unset)* | SHA256 hash | string | opt-in | Validate installer checksum | [defaults/main.yml](defaults/main.yml) |
| <a name="checksum_url"></a>`checksum_url` | *(unset)* | URL | string | opt-in | URL to retrieve checksum | [defaults/main.yml](defaults/main.yml) |
| <a name="levonk_package_cache_file"></a>`levonk_package_cache_file` | `/var/tmp/levonk_package_cache.json` | `/tmp/mycache.json` | string | opt-out | Path for stateful cache | [defaults/main.yml](defaults/main.yml) |
| <a name="levonk_package_manager"></a>`levonk_package_manager` | `auto` | `brew` | string | opt-out | Override detected package manager | [defaults/main.yml](defaults/main.yml) |
| <a name="levonk_package_cache_expiry_minutes"></a>`levonk_package_cache_expiry_minutes` | `60` | `30` | int | opt-out | Minutes before cache is considered stale | [defaults/main.yml](defaults/main.yml) |

---

### Requirements

- Ansible 2.9+
- Python 3.6+
- Supported platforms: Linux, macOS, Windows (see above)

---

### Dependencies

None.

---

### Example Playbooks

```yaml
- hosts: all
  roles:
    - role: levonk.common.package
      vars:
        name: "curl"
        state: "latest"
        update_cache: true
```

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
