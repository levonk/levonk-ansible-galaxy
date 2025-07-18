# Ansible Role: reboot_manager

An Ansible role to provide a centralized, safe, and decoupled mechanism for handling system reboots.

## Description

This role's sole purpose is to check for a fact named `reboot_required`. If this fact is set to `true`, the role will trigger a safe system reboot. This decouples the decision to reboot from the action itself, allowing other roles to signal the need for a reboot without having to implement the reboot logic themselves.

This approach makes the overall Ansible environment more modular, predictable, and maintainable.

## Requirements

-   This role requires the `ansible.builtin.reboot` module on the control node.

## Role Variables

This role is controlled by the `reboot_required` fact:

-   `reboot_required`: A boolean fact. If `true`, the role will trigger a reboot. Defaults to `false`.

## Dependencies

None.

## Example Playbook

This role is best used at the end of a playbook run to handle any pending reboots.

```yaml
---
- hosts: all
  become: true
  roles:
    - role: some_other_role_that_might_set_reboot_required
    - role: levonk.base_system.syscheck

- hosts: all
  become: true
  roles:
    - role: levonk.base_system.reboot_manager
```

## License

AGPL-3.0-or-later

## Author Information

This role was created by an AI assistant based on user requirements.
