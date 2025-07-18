# Ansible Role: levonk.vibeops.wsl_setup

This role installs and configures the Windows Subsystem for Linux (WSL2) and a specified Linux distribution on Windows systems.

## Description

The role is designed to automate the setup of a WSL2 environment. It performs the following actions:

1. Enables the `Microsoft-Windows-Subsystem-Linux` and `VirtualMachinePlatform` Windows features.
2. Reboots the machine if required after enabling the features.
3. Sets WSL2 as the default version for all new distributions.
4. Installs a specified Linux distribution (defaults to Debian).

The role is idempotent and will not make changes if WSL2 and the specified distribution are already installed. It is designed to run only on Windows systems and will be skipped on other operating systems.

## Requirements

- Administrator privileges are required on the Windows host to enable features and install software.

## Role Variables

The following variables are used by this role:

| Variable             | Required | Default | Description                                      |
|----------------------|----------|---------|--------------------------------------------------|
| `wsl_distribution`   | No       | `Debian`| The name of the WSL distribution to install from the Microsoft Store. |

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: windows_hosts
  roles:
    - role: levonk.vibeops.wsl_setup
      vars:
        wsl_distribution: Ubuntu-22.04
```

## License

Copyright (c) 2025, Brillarc, LLC

## Author Information

This role was created in 2025 by Brillarc, LLC.
