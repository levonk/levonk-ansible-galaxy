# Ansible Role: levonk.vibeops.tools

This role installs a collection of general-purpose tools, with support for conditional installation of graphical applications.

## Description

This role is designed to be a centralized place for installing common utilities. Currently, it supports the installation of:

-   **Ditto**: A clipboard manager for Windows.

The installation of graphical tools is controlled by the `graphical` variable. By default, no graphical tools are installed.

## Requirements

-   For Windows, Chocolatey is required to install packages.

## Role Variables

| Variable    | Required | Default | Description                                                                 |
|-------------|----------|---------|-----------------------------------------------------------------------------|
| `graphical` | No       | `false` | When set to `true`, the role will install graphical tools like Ditto. |

## Dependencies

None.

## Example Playbook

To install tools, including graphical applications like Ditto, include the role in your playbook and set the `graphical` variable to `true`:

```yaml
---
- hosts: windows_hosts
  roles:
    - role: levonk.vibeops.tools
      vars:
        graphical: true
```

## License

Copyright (c) 2025, Brillarc, LLC

## Author Information

This role was created in 2025 by Brillarc, LLC.
