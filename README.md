<!--
Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
-->

# levonk-ansible-galaxy

This repository contains a collection of Ansible roles for managing and provisioning development and operational environments.

## Available Roles

### levonk.vibeops

| Role                                                                                              | Description                                                                 |
| ------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| [devops](./levonk/vibeops/roles/devops/README.md)                                                   | Installs essential DevOps tools like Vagrant and Packer across multiple OS. |

### levonk.base_system

| Role                                                                                                | Description                                                         |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| [syscheck](./levonk/base_system/roles/syscheck/README.md)                                             | Performs asynchronous system integrity checks (sfc, fsck, etc.).    |
| [reboot_manager](./levonk/base_system/roles/reboot_manager/README.md)                                 | Handles system reboots when signaled by the `reboot_required` fact. |


