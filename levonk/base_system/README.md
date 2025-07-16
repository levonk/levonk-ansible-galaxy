# levonk.base_system Collection

This Ansible Galaxy collection provides foundational OS configuration, user setup, and cross-platform (Linux, macOS, Windows) bootstrapping roles. It is designed for use as the first step in provisioning a new host.

## Included Roles

| Role        | Description                               |
|-------------|-------------------------------------------|
| base_system | Core OS packages and networking setup      |
| user_setup  | User account, SSH/GPG, chezmoi management |

## Installation
```bash
ansible-galaxy collection install levonk.base_system
```

## Usage Example
```yaml
- hosts: all
  collections:
    - levonk.base_system
  roles:
    - role: base_system
    - role: user_setup
      vars:
        user_use_chezmoi: true
        chezmoi_repo_url: "https://github.com/example/dotfiles"
        username: alice-202507-myhost
```

## Requirements
- Ansible 2.9+
- Supported OS: Linux (Debian/Ubuntu), macOS, Windows

## License
AGPL-3.0-only

## Author
levonk <v3l8dud3@lkara.com>
