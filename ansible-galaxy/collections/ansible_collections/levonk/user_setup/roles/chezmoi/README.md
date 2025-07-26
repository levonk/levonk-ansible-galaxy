# Ansible Role: levonk.user_setup.chezmoi

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/chezmoi)

This role installs and configures [chezmoi](https://www.chezmoi.io/) for dotfiles management across Linux, macOS, and Windows. It supports package manager or vetted script installation, and initializes chezmoi with a user-supplied repository.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/chezmoi/tasks):

| Feature/Task                   | Description                                              | Required Variable(s)                  | Source |
|------------------------------- |---------------------------------------------------------|---------------------------------------|--------|
| Pre-flight checks              | Fails if `chezmoi_repo` is not defined                  | [`chezmoi_repo`](#chezmoi_repo)       | [tasks/main.yml](tasks/main.yml) |
| Install chezmoi (Linux)        | Installs chezmoi via package or vetted script           | None                                  | [tasks/Linux.yml](tasks/Linux.yml) |
| Install chezmoi (macOS)        | Installs chezmoi via Homebrew or vetted script          | None                                  | [tasks/Darwin.yml](tasks/Darwin.yml) |
| Install chezmoi (Debian)       | Installs chezmoi via vetted script                      | None                                  | [tasks/Debian.yml](tasks/Debian.yml) |
| Install chezmoi (Windows)      | Installs chezmoi via package or vetted script           | None                                  | [tasks/Windows.yml](tasks/Windows.yml) |
| Configure chezmoi              | Initializes chezmoi with repo, applies dotfiles         | [`chezmoi_repo`](#chezmoi_repo)       | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Pre-flight Checks
**Description:**
> Ensures the required variable `chezmoi_repo` is defined and not empty before proceeding. Fails early if not set.
- **Tags:** `always`
- **Usage:**
  - Set `chezmoi_repo` to your dotfiles repo URL.

### Install chezmoi (Linux/macOS/Windows/Debian)
**Description:**
> Installs chezmoi using the system package manager if available, or falls back to a vetted script installer. Ensures idempotent, secure installation across platforms.
- **Tags:** `chezmoi`, `linux`, `macos`, `windows`, `user_setup`
- **Idempotency:** Safe to run repeatedly; only installs if not present.
- **Security:** Uses official package or HTTPS-vetted script.

### Configure chezmoi
**Description:**
> Initializes chezmoi with the provided repo and applies dotfiles to the user's home directory.
- **Tags:** `chezmoi_configure`, `user_setup`
- **Idempotency:** Only initializes if chezmoi is not already set up.
- **Usage:**
  - Set `chezmoi_repo` to your dotfiles repo URL.

## Requirements

- `git` must be installed on the target machine.
- The `levonk.common.roles.vet_script_installer` role is required as a dependency.

## Role Variables

The following variables are used by this role:

| Variable       | Required | Default | Description                                      |
|----------------|----------|---------|--------------------------------------------------|
| `chezmoi_repo` | Yes      | `null`  | The URL of the Git repository containing your dotfiles. |

## Dependencies

- `levonk.common.roles.vet_script_installer`

## Example Playbook

```yaml
---
- hosts: all
  vars:
    chezmoi_repo: "https://github.com/username/dotfiles.git"
  roles:
    - role: levonk.user_setup.chezmoi
```

## License

Copyright (c) 2025, Brillarc, LLC

## Author Information

This role was created in 2025 by Brillarc, LLC.
