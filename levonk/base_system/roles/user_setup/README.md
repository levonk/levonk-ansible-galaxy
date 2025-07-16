# user_setup Role

This role manages user account creation, SSH/GPG key setup, and optional dotfile management using chezmoi. It is cross-platform (macOS, Debian/Ubuntu, Windows) and is configurable for different user personas.

## Features
- Creates user accounts with secure defaults
- Generates SSH and GPG keys per user
- Manages `authorized_keys` via Ansible Vault
- Optionally bootstraps user dotfiles with chezmoi
- Disables password login by default

## Usage
```yaml
- hosts: all
  roles:
    - role: user_setup
      vars:
        user_use_chezmoi: true
        chezmoi_repo_url: "https://github.com/example/dotfiles"
        username: alice-202507-myhost
```

## Requirements
- Ansible 2.9+
- Supported OS: Linux (Debian/Ubuntu), macOS, Windows

## Variables
See `vars/main.yml` for configurable options.

## License
AGPL-3.0-only

## Author
levonk
