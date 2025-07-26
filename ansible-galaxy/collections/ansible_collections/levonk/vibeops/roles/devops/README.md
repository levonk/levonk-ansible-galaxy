# Ansible Role: levonk.vibeops.devops

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/devops)

This role provisions a cross-platform DevOps toolchain, including Packer, Terraform, Vagrant, Docker Desktop, VirtualBox, and gitkeeper. Documentation follows strict best-practices boilerplate.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/devops/tasks):

| Feature/Task            | Description                                          | Required Variable(s)                | Source |
|-------------------------|------------------------------------------------------|-------------------------------------|--------|
| Install Packer          | Installs HashiCorp Packer (multi-platform)           | N/A                                | [tasks/packer.yml](tasks/packer.yml) |
| Install Terraform       | Installs HashiCorp Terraform (multi-platform)        | N/A                                | [tasks/terraform.yml](tasks/terraform.yml) |
| Install Vagrant         | Installs HashiCorp Vagrant (multi-platform)          | `devops_virtualization_enabled`     | [tasks/vagrant.yml](tasks/vagrant.yml) |
| Install Docker Desktop  | Installs Docker Desktop (multi-platform, graphical)  | N/A                                | [tasks/docker_desktop.yml](tasks/docker_desktop.yml) |
| Install VirtualBox      | Installs VirtualBox or Guest Additions               | N/A                                | [tasks/virtualbox.yml](tasks/virtualbox.yml) |
| Install gitkeeper       | Installs gitkeeper Go tool (opt-in)                  | `devops_install_gitkeeper`          | [tasks/gitkeeper.yml](tasks/gitkeeper.yml) |

---

## Detailed Feature Documentation

### Install Packer
**Description:** Installs HashiCorp Packer on Debian, RedHat, macOS, and Windows using official repositories or package managers.
- **Supported Platforms:** Debian, RedHat, macOS, Windows
- **Tags:** `devops`, `packer`, `hashicorp`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official HashiCorp sources.
- **Usage:** Enabled by default; no variables needed.

### Install Terraform
**Description:** Installs HashiCorp Terraform on Debian, RedHat, macOS, and Windows using official repositories or package managers.
- **Supported Platforms:** Debian, RedHat, macOS, Windows
- **Tags:** `devops`, `terraform`, `hashicorp`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official HashiCorp sources.
- **Usage:** Enabled by default; no variables needed.

### Install Vagrant
**Description:** Installs Vagrant on Debian, macOS, and Windows using official repositories or package managers. Controlled by `devops_virtualization_enabled` (opt-out).
- **Supported Platforms:** Debian, macOS, Windows
- **Tags:** `devops`, `vagrant`, `hashicorp`, `virtualization`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official HashiCorp sources.
- **Usage:** Enabled by default; set `devops_virtualization_enabled: false` to skip.

### Install Docker Desktop
**Description:** Installs Docker Desktop on supported platforms (Debian, Windows, macOS) if the `graphical` tag is present.
- **Supported Platforms:** Debian, Windows, macOS
- **Tags:** `devops`, `docker`, `docker-desktop`, `graphical`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official Docker sources.
- **Usage:** Enabled if `graphical` tag is present; no variables needed.

### Install VirtualBox
**Description:** Installs VirtualBox or Guest Additions depending on environment.
- **Supported Platforms:** Debian, RedHat, Windows, macOS
- **Tags:** `devops`, `virtualbox`, `virtualization`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official sources.
- **Usage:** Enabled by default; no variables needed.

### Install gitkeeper
**Description:** Installs gitkeeper Go tool if `devops_install_gitkeeper` is true (opt-in). Requires Go environment.
- **Supported Platforms:** All (with Go installed)
- **Tags:** `devops`, `gitkeeper`, `go`, `tools`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official Go install method.
- **Usage:** Set `devops_install_gitkeeper: true` to enable.

---

## Usage

### Variables

#### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

---

#### Variable Reference

| Variable                      | Default | Sample Value | Type  | Activation | Purpose                                         | Used In |
|-------------------------------|---------|--------------|-------|------------|-------------------------------------------------|---------|
| `devops_virtualization_enabled`| `true`  | `false`      | bool  | opt-out    | Enables/disables virtualization tools (Vagrant) | [tasks/vagrant.yml](tasks/vagrant.yml) |
| `devops_install_gitkeeper`     | `false` | `true`       | bool  | opt-in     | Enables gitkeeper Go tool installation          | [tasks/gitkeeper.yml](tasks/gitkeeper.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, RedHat, macOS, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `yum` (RedHat), `chocolatey` (Windows), `brew` (macOS)
- Go must be installed for gitkeeper

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.devops
      vars:
        devops_virtualization_enabled: true   # opt-out, default true
        devops_install_gitkeeper: true        # opt-in, default false
```

---

## Best Practices for Role Documentation

- **Always document every variable** in a table with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- **Link to the source** of each feature/task and variable usage for transparency and maintainability.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Reference external specs or requirements** where relevant.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new roles and features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the MIT License. See LICENSE file in the project root for full license information.

