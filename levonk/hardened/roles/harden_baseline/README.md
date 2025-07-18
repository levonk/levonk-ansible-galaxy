# Ansible Role: harden_baseline

## Description

This role applies a minimal set of baseline security hardening configurations to a system. It is designed to be a foundational layer for more specific security roles.

## Features

-   **SSH Hardening**: Disables password-based authentication in favor of key-based authentication on Linux systems.
-   **Firewall Management**: Ensures the host-based firewall is enabled on Linux, macOS, and Windows.
-   **Secure Scripting Tools**:
    -   Installs `shellcheck` and `bat` on Debian-based systems for improved shell scripting.
    -   Installs `vet` to safely inspect and run shell scripts from the internet, avoiding `curl | sh` anti-patterns.
-   **Configuration Auditing with etckeeper**:
    -   Installs and configures `etckeeper` on Linux systems.
    -   Initializes a `git` repository in `/etc` to track changes to configuration files, providing a complete audit trail.

## Requirements

-   Requires `root` or `sudo` privileges to apply system-level changes.
-   For Debian/Ubuntu systems, `apt` is used.
-   For RedHat/CentOS/Fedora systems, `yum` or `dnf` is used.
-   For Windows, `win_firewall` module is used.

## Role Variables

| Variable                  | Default | Description                                             |
| ------------------------- | ------- | ------------------------------------------------------- |
| `etckeeper_commit_changes` | `true`  | Whether to automatically commit changes after a run. |

## Dependencies

This role has no external Ansible role dependencies.

## Example Playbook

```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.hardened.harden_baseline
```

## License

AGPL-3.0-only

## Author Information

This role was created by [levonk](mailto:v3l8dud3@lkara.com).
