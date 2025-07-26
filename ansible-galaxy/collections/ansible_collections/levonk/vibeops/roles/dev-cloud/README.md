# Ansible Role: levonk.vibeops.dev-cloud

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-cloud)

This role installs and configures cloud development CLIs and tools (Google Cloud SDK, AWS CLI, Azure CLI, KICS) across Linux, macOS, and Windows. It uses platform-native package managers and secure vetting for downloaded scripts where possible.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-cloud/tasks):

| Feature/Task            | Description                                  | Required Variable(s) | Source |
|-------------------------|----------------------------------------------|----------------------|--------|
| Install Google Cloud SDK| Installs gcloud CLI for cloud operations     | N/A                 | [tasks/Debian.yml](tasks/Debian.yml), [tasks/Darwin.yml](tasks/Darwin.yml), [tasks/Windows.yml](tasks/Windows.yml) |
| Install AWS CLI         | Installs AWS CLI for Amazon Web Services     | N/A                 | [tasks/Debian.yml](tasks/Debian.yml), [tasks/Darwin.yml](tasks/Darwin.yml), [tasks/Windows.yml](tasks/Windows.yml) |
| Install Azure CLI       | Installs Azure CLI for Microsoft Azure       | N/A                 | [tasks/Darwin.yml](tasks/Darwin.yml), [tasks/Windows.yml](tasks/Windows.yml) |
| Install KICS            | Installs KICS for IaC security scanning      | N/A                 | [tasks/Debian.yml](tasks/Debian.yml), [tasks/Darwin.yml](tasks/Darwin.yml), [tasks/Windows.yml](tasks/Windows.yml) |

---

## Detailed Feature Documentation

### Install Google Cloud SDK
- **Description:** Installs Google Cloud SDK (`gcloud`) using Homebrew (macOS), Chocolatey (Windows), or direct download and vetting (Debian/Linux).
- **Tags:** `cloud`, `gcp`, `gcloud`, `cli`
- **Idempotency:** Checks for existence before installing; safe to run repeatedly.
- **Security:** Vetting of installer scripts on Linux.

### Install AWS CLI
- **Description:** Installs AWS CLI using Homebrew, Chocolatey, or direct download (Debian/Linux).
- **Tags:** `cloud`, `aws`, `cli`
- **Idempotency:** Checks for existence before installing; safe to run repeatedly.

### Install Azure CLI
- **Description:** Installs Azure CLI using Homebrew (macOS) or Chocolatey (Windows).
- **Tags:** `cloud`, `azure`, `cli`
- **Idempotency:** Checks for existence before installing; safe to run repeatedly.

### Install KICS
- **Description:** Installs KICS for infrastructure-as-code security scanning, using Homebrew, Chocolatey, or direct download and vetting (Debian/Linux).
- **Tags:** `security`, `iac`, `kics`, `cli`
- **Idempotency:** Checks for existence before installing; safe to run repeatedly.
- **Security:** Vetting of installer scripts on Linux.

---

## Usage

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `brew` (macOS), `chocolatey` (Windows)

---

### Dependencies
- levonk.common.vet_script_installer

---

### Example Playbook
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.dev-cloud
```

---

## Contributing
Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License
Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
