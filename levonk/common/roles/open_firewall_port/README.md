# Ansible Role: levonk.common.open_firewall_port

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/open_firewall_port)

Opens a firewall port for a local service, cross-platform and idempotent. Supports UFW (Debian/Ubuntu), firewalld (RedHat), pf (macOS), and Windows Defender Firewall.

---


## Supported Firewalls
- UFW (Debian/Ubuntu)
- firewalld (RedHat/Fedora/CentOS)
- pf (macOS)
- Windows Defender Firewall

---

## Idempotency & Safety
- Tasks only run if the firewall is installed and enabled.
- macOS: Appends rule to `/etc/pf.conf` and reloads pf.
- Windows: Creates a named inbound rule.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/open_firewall_port/tasks):

| Feature/Task                   | Description                                                        | Required Variable(s)                 | Source |
|--------------------------------|--------------------------------------------------------------------|--------------------------------------|--------|
| Open port in UFW (Debian/Ubuntu) | Allows port via UFW if installed and running                      | [`open_firewall_port_port`](#open_firewall_port_port) | [tasks/main.yml](tasks/main.yml) |
| Open port in firewalld (RedHat)  | Allows port via firewalld if installed and running                | [`open_firewall_port_port`](#open_firewall_port_port) | [tasks/main.yml](tasks/main.yml) |
| Open port in pf (macOS)          | Appends rule to /etc/pf.conf and reloads pf if present            | [`open_firewall_port_port`](#open_firewall_port_port) | [tasks/main.yml](tasks/main.yml) |
| Open port in Windows Defender    | Creates named inbound rule if service is running                  | [`open_firewall_port_port`](#open_firewall_port_port) | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Open port in UFW (Debian/Ubuntu)
- **Description:** Opens a port via UFW if installed and enabled.
- **Supported Platforms:** Debian, Ubuntu
- **Tags:** `firewall`, `ufw`, `debian`, `ubuntu`
- **Idempotency:** Only runs if UFW is installed and running.
- **Security:** Uses official Ansible modules.
- **Usage:** Set required variables (see below).

### Open port in firewalld (RedHat)
- **Description:** Opens a port via firewalld if installed and enabled.
- **Supported Platforms:** RedHat, Fedora, CentOS
- **Tags:** `firewall`, `firewalld`, `redhat`, `centos`, `fedora`
- **Idempotency:** Only runs if firewalld is installed and running.
- **Security:** Uses official Ansible modules.

### Open port in pf (macOS)
- **Description:** Appends rule to `/etc/pf.conf` and reloads pf if present and running.
- **Supported Platforms:** macOS
- **Tags:** `firewall`, `pf`, `macos`
- **Idempotency:** Only runs if pfctl is present and running.
- **Security:** Uses official Ansible modules and system commands.

### Open port in Windows Defender Firewall
- **Description:** Creates a named inbound rule if Windows Defender Firewall service is running.
- **Supported Platforms:** Windows
- **Tags:** `firewall`, `windows`, `defender`
- **Idempotency:** Only runs if MpsSvc is running.
- **Security:** Uses official Ansible modules.

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
| <a name="open_firewall_port_port"></a>`open_firewall_port_port` | *(unset)* | `8080` | int/string | required | Port to open | [tasks/main.yml](tasks/main.yml) |
| <a name="open_firewall_port_proto"></a>`open_firewall_port_proto` | `tcp` | `udp` | string | opt-out | Protocol to use (tcp/udp) | [vars/main.yml](vars/main.yml) |
| <a name="open_firewall_port_service"></a>`open_firewall_port_service` | `local service` | `myapp` | string | opt-out | Service description for rule comments | [vars/main.yml](vars/main.yml) |

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
    - role: levonk.common.open_firewall_port
      vars:
        open_firewall_port_port: 8080
        open_firewall_port_proto: tcp
        open_firewall_port_service: "myapp"
```

---

## Best Practices for Role Documentation
- **Always document every variable** in a table with: name, default, sample, type, activation, purpose, and source link.
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

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.


