# How to Use the Shared vet_script_installer Role

## Overview
The `levonk/common/roles/vet_script_installer` role provides a secure, reusable way to download, vet, and execute any shell script or plugin installer. This centralizes your script/plugin install policy and ensures all scripts are statically analyzed before execution.

## Usage Example
Add the role to your playbook and provide the required variables:

```yaml
- hosts: all
  roles:
    - role: levonk.common.roles.vet_script_installer
      vars:
        vet_script_url: "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
        vet_script_dest: "/tmp/ohmyzsh-install.sh"
        vet_script_args: "--unattended"
```

- `vet_script_url`: The URL to the script you want to install
- `vet_script_dest`: Where to save the script on the target
- `vet_script_args`: (optional) Any arguments to pass to the script

## Referencing from Other Roles/Playbooks
You can call this role from any other role or playbook that needs to securely install a shell plugin or third-party script.

### Example: In Another Role
```yaml
- name: Securely install Oh My Zsh
  include_role:
    name: levonk.common.roles.vet_script_installer
  vars:
    vet_script_url: "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
    vet_script_dest: "/tmp/ohmyzsh-install.sh"
    vet_script_args: "--unattended"
```

## Benefits
- Updates to the vetting process are made in one place.
- All script/plugin installs are consistent and auditable.
- Easy to extend for additional compliance checks.

## Contributing
- Extend this role for other OSes or advanced vetting as needed.
- Document new patterns in `docs/config-management/patterns`.

---
**For more patterns, see:** `docs/config-management/patterns/secure-script-installation.md`
