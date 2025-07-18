# Ansible Role: syscheck

An Ansible role to perform asynchronous system integrity checks on Windows, macOS, and Linux systems.

## Description

This role initiates non-blocking system integrity checks suitable for running in the background without halting an Ansible playbook run. The checks performed are specific to the target operating system:

-   **Windows**: Runs the System File Checker (`sfc /scannow`).
-   **macOS**: Verifies the main system volume (`diskutil verifyVolume /`).
-   **Linux (Debian/RedHat)**: Schedules a filesystem check to run on the next reboot by creating the `/forcefsck` file. This is paired with a handler to trigger the reboot.

## Requirements

-   For Windows targets, `ansible.windows.win_shell` is used.
-   For Linux targets, the `ansible.builtin.reboot` module is required on the control node if the reboot handler is triggered.

## Role Variables

None.

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: all
  become: true
  roles:
    - role: levonk.base_system.syscheck
```

## License

AGPL-3.0-or-later

## Author Information

This role was created by an AI assistant based on user requirements.
