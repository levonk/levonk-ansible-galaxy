# Ansible Role: levonk.base_system.reboot_manager

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/base_system/roles/reboot_manager)

A centralized, safe, and decoupled mechanism for handling system reboots in Ansible. This role enables other roles to signal a reboot without implementing reboot logic themselves, improving modularity and maintainability.

---

## Features & Tasks

| Feature/Task      | Description                                                        | Required Variable(s)      | Source |
|-------------------|--------------------------------------------------------------------|---------------------------|--------|
| Conditional Reboot| Reboots system if `reboot_required` is set to `true`               | [`reboot_required`](#reboot_required) | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/reboot_manager/tasks/main.yml) |

---

## Detailed Feature Documentation

### Conditional System Reboot

**Description:**
> Triggers a safe system reboot only if the `reboot_required` fact is set to `true`. This allows other roles or tasks to request a reboot in a decoupled, predictable way.

- **Tags:** `reboot_manager`
- **Idempotency:** Role is safe to run repeatedly; only triggers reboot if requested.
- **Security:** Uses only the trusted `ansible.builtin.reboot` module. No custom scripts executed.
- **Testing:** Recommend using Molecule scenario with a play that sets `reboot_required: true` and verifies reboot.
- **Usage:**
  - Set the `reboot_required` fact or variable to `true` in any prior task or role.
  - Example:
    ```yaml
    - hosts: all
      tasks:
        - name: Request reboot
          set_fact:
            reboot_required: true
    - hosts: all
      roles:
        - role: levonk.base_system.reboot_manager
    ```

---

## Variables

### Variable Table Legend

- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

### Variable Reference

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| <a name="reboot_required"></a>`reboot_required` | `false` | `true` | bool | opt-in | Triggers reboot if set to true | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/levonk/base_system/roles/reboot_manager/tasks/main.yml) |

---

## Example Playbook

```yaml
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
