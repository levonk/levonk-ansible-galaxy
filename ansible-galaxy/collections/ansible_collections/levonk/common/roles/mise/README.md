# levonk.common.mise

Install the Mise runtime manager (https://mise.jdx.dev) cross‑platform with idempotency.

## Features
- Linux/macOS install via official installer
- Windows install via Scoop, fallback to winget
- Idempotent checks per OS
- Toggleable via defaults

## Role Variables
- `common_mise_install` (bool, default: `true`)
  - Whether to install Mise.

## Tags
- `developer`
- `tools`
- `mise`

## Requirements
- For Windows Scoop path detection, environment variable `SCOOP` is used when present.
- Network access to download installer or packages.

## Example Playbooks
Install with defaults:
```yaml
- hosts: all
  roles:
    - role: levonk.common.mise
```

Conditionally install:
```yaml
- hosts: all
  roles:
    - role: levonk.common.mise
      vars:
        common_mise_install: false
```

From another role (include_role):
```yaml
- name: Ensure Mise installed
  ansible.builtin.include_role:
    name: levonk.common.mise
  vars:
    common_mise_install: true
```

## Notes
- If you previously included `install_mise.yml` from `levonk.vibeops.developer`, that path now delegates to this role for backward compatibility.

---
Copyright (c) 2025 the person whos account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
