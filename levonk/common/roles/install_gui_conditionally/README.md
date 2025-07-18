# Ansible Role: install_gui_conditionally

This role installs a graphical user interface (GUI) on a system if it doesn't have one and the `graphical` tag is specified during the Ansible run.

## Requirements

None.

## Role Variables

None.

## Dependencies

None.

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: levonk.common.install_gui_conditionally
```

To run this role, use the `graphical` tag:

```bash
ansible-playbook playbook.yml --tags graphical
```

## License

Brillarc, LLC

## Author Information

Levon Becker
