# Ansible Role: user_setup

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/base_system/roles/user_setup)

Cross-platform user account setup, SSH/GPG key generation, and dotfiles bootstrapping (chezmoi) for Linux, macOS, and Windows.

---

## Features & Tasks

| Feature/Task                  | Description                                                                 | Required Variable(s)                              | Source |
|-------------------------------|-----------------------------------------------------------------------------|---------------------------------------------------|--------|
| Ensure user account exists    | Creates user on Linux/macOS/Windows                                         | [`username`](#username)                           | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/user_setup/tasks/main.yml) |
| Generate SSH key (Linux/macOS)| Creates 4096-bit RSA key for user                                           | [`username`](#username)                           | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/user_setup/tasks/main.yml) |
| Generate GPG key (Linux/macOS)| Generates GPG key for user (batch mode)                                     | [`username`](#username)                           | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/user_setup/tasks/main.yml) |
| Disable password login        | Locks password for user (Linux/macOS)                                       | [`username`](#username)                           | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/user_setup/tasks/main.yml) |
| Install chezmoi               | Installs chezmoi for dotfiles management (all platforms, opt-in)            | [`user_use_chezmoi`](#user_use_chezmoi)           | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/user_setup/tasks/main.yml) |
| Initialize chezmoi            | Runs chezmoi init/apply for user (Linux/macOS, opt-in)                      | [`chezmoi_repo_url`](#chezmoi_repo_url), `username`, `user_use_chezmoi` | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/user_setup/tasks/main.yml) |

---

## Detailed Feature Documentation

### Ensure User Account Exists
- **Description:** Creates a user account on Linux/macOS (`ansible.builtin.user`) or Windows (`ansible.windows.win_user`).
- **Tags:** `user_setup`, `user`, `account`, `crossplatform`
- **Idempotency:** Safe to run repeatedly; only creates user if not present.
- **Security:** Uses trusted Ansible modules.
- **Usage:** Set `username` variable.

### Generate SSH Key (Linux/macOS)
- **Description:** Generates a 4096-bit RSA keypair for the user if not present.
- **Tags:** `user_setup`, `ssh`, `linux`, `macos`
- **Idempotency:** Only creates key if not present.
- **Security:** Uses Ansible's `openssh_keypair` module.
- **Usage:** Set `username` variable.

### Generate GPG Key (Linux/macOS)
- **Description:** Generates a GPG key for the user in batch mode if not present.
- **Tags:** `user_setup`, `gpg`, `linux`, `macos`
- **Idempotency:** Only generates if not present.
- **Security:** Uses `gpg` in batch mode.
- **Usage:** Set `username` variable. Ensure `/home/{{ username }}/gpg_batch.cfg` exists.

### Disable Password Login (Linux/macOS)
- **Description:** Locks password for the user account.
- **Tags:** `user_setup`, `security`, `linux`, `macos`
- **Idempotency:** Only locks if not already locked.
- **Security:** Prevents password login for user.
- **Usage:** Set `username` variable.

### Install chezmoi (All platforms, opt-in)
- **Description:** Installs chezmoi using `levonk.common.package` role if `user_use_chezmoi` is true.
- **Tags:** `user_setup`, `chezmoi`, `dotfiles`, `crossplatform`
- **Idempotency:** Only installs if not present or outdated.
- **Security:** Uses trusted package sources.
- **Usage:** Set `user_use_chezmoi: true`.

### Initialize chezmoi for User (Linux/macOS, opt-in)
- **Description:** Initializes and applies chezmoi config for user using `chezmoi_repo_url`.
- **Tags:** `user_setup`, `chezmoi`, `dotfiles`, `linux`, `macos`
- **Idempotency:** Only runs if chezmoi is enabled and repo URL is set.
- **Security:** Runs as target user.
- **Usage:** Set `username`, `user_use_chezmoi: true`, and `chezmoi_repo_url`.

---

## Variables

### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

### Variable Reference

| Variable            | Default | Sample Value            | Type   | Activation | Purpose                                    | Used In |
|---------------------|---------|------------------------|--------|------------|--------------------------------------------|---------|
| `username`          | ""      | "alice"                | str    | required   | Name of user account to create/configure   | All     |
| `user_use_chezmoi`  | false   | true                   | opt-in | opt-in     | Enable chezmoi dotfiles bootstrapping      | chezmoi |
| `chezmoi_repo_url`  | ""      | "git@github.com:user/dotfiles.git" | str | opt-in | Repo URL for chezmoi init                  | chezmoi |

---

## Example Playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: levonk.base_system.user_setup
      vars:
        username: "alice"
        user_use_chezmoi: true
        chezmoi_repo_url: "git@github.com:alice/dotfiles.git"
```

---

## Best Practices for Role Documentation
- **Document every variable** in a table with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status.
- **Link to the source** of each feature/task for transparency.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new roles and features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
