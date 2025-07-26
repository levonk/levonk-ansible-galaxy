# Ansible Role: levonk.user_setup.local_user

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/local_user)

This role configures a local (non-remote, non-service) user account with secure defaults, ensuring the user exists, their shell is installed, and their authorized SSH keys are set. Supports Linux, macOS, and Windows.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/local_user/tasks):

| Feature/Task                  | Description                                              | Required Variable(s)                        | Source |
|-------------------------------|---------------------------------------------------------|---------------------------------------------|--------|
| Ensure shell installed        | Installs the specified shell for the user if needed      | [`local_user_shell`](#local_user_shell)     | [tasks/main.yml](tasks/main.yml) |
| Ensure local user exists      | Creates or updates the user with provided attributes     | [`local_user_name`](#local_user_name)       | [tasks/main.yml](tasks/main.yml) |
| Set authorized SSH keys       | Adds SSH keys to user's authorized_keys                  | [`local_user_ssh_keys`](#local_user_ssh_keys) | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Ensure shell for local user is installed
**Description:**
> Ensures the specified shell is installed for the user, unless set to nologin/false. Uses `levonk.common.package` abstraction for cross-platform support.
- **Tags:** `local_user`, `shell`
- **Idempotency:** Only installs if not present.
- **Usage:**
  - Set `local_user_shell` to the desired shell path (default: `/bin/bash`).

### Ensure local user exists
**Description:**
> Creates or updates the user with the specified name, shell, and groups.
- **Tags:** `local_user`
- **Idempotency:** User is created or updated as needed.
- **Usage:**
  - Set `local_user_name` (required), `local_user_shell`, and `local_user_groups` as needed.

### Set authorized SSH keys
**Description:**
> Adds public SSH keys to the user's `authorized_keys` for secure access.
- **Tags:** `local_user`, `ssh`
- **Idempotency:** Only adds keys if not already present.
- **Usage:**
  - Set `local_user_ssh_keys` to a list of public keys.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

#### Variable Reference

| Variable                        | Default        | Sample Value                    | Type   | Activation | Purpose                                    | Used In |
|----------------------------------|---------------|---------------------------------|--------|------------|--------------------------------------------|---------|
| <a name="local_user_name"></a>`local_user_name`         | *(unset)*      | `myuser`                          | string | required   | Username to create/manage                  | [tasks/main.yml](tasks/main.yml) |
| <a name="local_user_shell"></a>`local_user_shell`       | `/bin/bash`    | `/bin/zsh`                         | string | opt-out    | Shell for the user (set to nologin/false to disable login) | [tasks/main.yml](tasks/main.yml) |
| <a name="local_user_groups"></a>`local_user_groups`     | `[]`           | `["sudo", "docker"]`             | list   | opt-in     | Additional groups for the user             | [tasks/main.yml](tasks/main.yml) |
| <a name="local_user_ssh_keys"></a>`local_user_ssh_keys` | `[]`           | `["ssh-ed25519 AAAA...", ...]`    | list   | opt-in     | SSH public keys to authorize for the user  | [tasks/main.yml](tasks/main.yml) |

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
    local_user_name: "myuser"
    local_user_shell: "/bin/zsh"
    local_user_groups:
      - sudo
      - docker
    local_user_ssh_keys:
      - "ssh-ed25519 AAAAC3Nza... user@host"
  roles:
    - role: levonk.user_setup.local_user
```

---

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License
Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the MIT License. See LICENSE file in the project root for full license information.
