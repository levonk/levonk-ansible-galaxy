# vet_script_installer: Secure Script Vetting Role

This role securely downloads, vets, and executes shell scripts/plugins using [vet](https://github.com/vet-run/vet).

## Usage Example
```yaml
- hosts: all
  roles:
    - role: levonk.common.roles.vet_script_installer
      vars:
        vet_script_url: "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
        vet_script_dest: "/tmp/ohmyzsh-install.sh"
        vet_script_args: "--unattended"
```

## Referencing from Other Roles/Playbooks
```yaml
- name: Securely install Oh My Zsh
  include_role:
    name: levonk.common.roles.vet_script_installer
  vars:
    vet_script_url: "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
    vet_script_dest: "/tmp/ohmyzsh-install.sh"
    vet_script_args: "--unattended"
```

## Directories
- `handlers/`, `library/`, `meta/`, `molecule/`, `plugins/`, `tasks/`, `templates/`, `tests/`, `vars/` included for blueprint compliance.

## Contributing
- Extend for more OS support or advanced checks as needed.
- See `docs/config-management/patterns/secure-script-installation.md` for pattern details.
