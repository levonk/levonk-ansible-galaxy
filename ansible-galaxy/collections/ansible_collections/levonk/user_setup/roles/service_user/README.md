# Ansible Role: levonk.user_setup.service_user

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/service_user)

This role configures a non-interactive service account with minimal privileges, ensuring the user exists and their shell is installed (typically nologin/false). Supports Linux, macOS, and Windows.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/service_user/tasks):

| Feature/Task                  | Description                                              | Required Variable(s)                        | Source |
|-------------------------------|---------------------------------------------------------|---------------------------------------------|--------|
| Ensure shell installed        | Installs the specified shell for the service user if needed | [`service_user_shell`](#service_user_shell) | [tasks/main.yml](tasks/main.yml) |
| Ensure service user exists    | Creates or updates the system service user with provided attributes | [`service_user_name`](#service_user_name)   | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Ensure shell for service user is installed
**Description:**
> Ensures the specified shell is installed for the service user, unless set to nologin/false. Uses `levonk.common.package` abstraction for cross-platform support.
- **Tags:** `service_user`, `shell`
- **Idempotency:** Only installs if not present.
- **Usage:**
  - Set `service_user_shell` to the desired shell path (default: `/usr/sbin/nologin`).

### Ensure service user exists
**Description:**
> Creates or updates the system service user with the specified name, shell, and groups. Sets the user as a system account.
- **Tags:** `service_user`
- **Idempotency:** User is created or updated as needed.
- **Usage:**
  - Set `service_user_name` (required), `service_user_shell`, and `service_user_groups` as needed.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable                        | Default                | Sample Value                    | Type   | Activation | Purpose                                    | Used In |
|----------------------------------|------------------------|---------------------------------|--------|------------|--------------------------------------------|---------|
| <a name="service_user_name"></a>`service_user_name`         | *(unset)*              | `svcuser`                          | string | required   | Username to create/manage                  | [tasks/main.yml](tasks/main.yml) |
| <a name="service_user_shell"></a>`service_user_shell`       | `/usr/sbin/nologin`    | `/bin/false`                       | string | opt-out    | Shell for the user (usually nologin/false) | [tasks/main.yml](tasks/main.yml) |
| <a name="service_user_groups"></a>`service_user_groups`     | `[]`                   | `["svcgroup"]`                    | list   | opt-in     | Additional groups for the user             | [tasks/main.yml](tasks/main.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, RedHat, MacOSX, Windows

---

### Dependencies
- `levonk.common.package` (for shell installation abstraction)

---

### Example Playbook
```yaml
- hosts: all
  become: yes
  vars:
    service_user_name: "svcuser"
    service_user_shell: "/bin/false"
    service_user_groups:
      - svcgroup
  roles:
    - role: levonk.user_setup.service_user
```

---

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License
Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the MIT License. See LICENSE file in the project root for full license information.
