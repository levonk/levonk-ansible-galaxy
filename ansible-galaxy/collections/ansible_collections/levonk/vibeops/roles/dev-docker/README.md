# Ansible Role: levonk.vibeops.dev-docker

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-docker)

This role sets up a cross-platform Docker development environment, including Docker CLI, Desktop/OrbStack, and a suite of tools for security, optimization, and UX. Documentation follows strict best-practices boilerplate.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-docker/tasks):

| Feature/Task                         | Description                                               | Required Variable(s) | Source |
|---------------------------------------|-----------------------------------------------------------|----------------------|--------|
| Install Docker CLI                    | Installs Docker CLI for container management              | `install_docker_cli` (opt-out) | [tasks/docker-cli.yml](tasks/docker-cli.yml) |
| Install Docker Desktop/OrbStack       | Installs Docker Desktop (Windows/Linux) or OrbStack (macOS)| `install_docker_desktop` (opt-out) | [tasks/docker-desktop.yml](tasks/docker-desktop.yml) |
| Install Dive                          | Installs Dive for exploring Docker images                  | `install_dive` (opt-out) | [tasks/dive.yml](tasks/dive.yml) |
| Install Security Tools                | Installs Trivy, Grype, Dockle, Clair                      | `install_docker_security` (opt-out), `install_clair` (opt-in) | [tasks/docker-security.yml](tasks/docker-security.yml) |
| Install Optimization Tools            | Installs Hadolint, Docker Slim, Compose Switch            | `install_docker_optimize` (opt-out) | [tasks/docker-optimize.yml](tasks/docker-optimize.yml) |
| Install UX Tools                      | Installs Stern, ctop, Dockerize, Portainer, Netshoot      | `install_docker_ux` (opt-out), `install_portainer` (opt-in), `install_netshoot` (opt-in) | [tasks/docker-ux.yml](tasks/docker-ux.yml) |

---

## Detailed Feature Documentation

### Install Docker CLI
**Description:** Installs the Docker CLI for managing containers, images, and networks. Includes Docker Compose and Compose Switch on supported platforms.
- **Supported Platforms:** Debian, Ubuntu, RedHat, MacOSX, Windows
- **Tags:** `docker`, `cli`, `core`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official repositories.
- **Usage:** Enabled by default; set `install_docker_cli: false` to opt-out.

### Install Docker Desktop/OrbStack
**Description:** Installs Docker Desktop (non-macOS) or OrbStack (macOS) for container runtime and graphical management.
- **Supported Platforms:** Windows, MacOSX
- **Tags:** `docker`, `desktop`, `orbstack`, `graphical`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official sources.
- **Usage:** Enabled by default; set `install_docker_desktop: false` to opt-out.

### Install Dive
**Description:** Installs Dive for inspecting Docker image layers and optimizing image size.
- **Supported Platforms:** Debian, Ubuntu, RedHat, MacOSX, Windows
- **Tags:** `docker`, `tools`, `dive`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official releases.
- **Usage:** Enabled by default; set `install_dive: false` to opt-out.

### Install Security Tools
**Description:** Installs Trivy, Grype, Dockle, and optionally Clair for container security scanning and vulnerability analysis.
- **Supported Platforms:** All
- **Tags:** `docker`, `security`, `trivy`, `grype`, `dockle`, `clair`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official releases.
- **Usage:** Enabled by default; set `install_docker_security: false` to opt-out. Set `install_clair: true` to enable Clair.

### Install Optimization Tools
**Description:** Installs Hadolint (Dockerfile linter), Docker Slim (minification), and Compose Switch for advanced optimization.
- **Supported Platforms:** All
- **Tags:** `docker`, `optimize`, `hadolint`, `docker-slim`, `compose-switch`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official releases.
- **Usage:** Enabled by default; set `install_docker_optimize: false` to opt-out.

### Install UX Tools
**Description:** Installs Stern (logs), ctop (metrics), Dockerize (utility), Portainer (web UI), and Netshoot (network troubleshooting container).
- **Supported Platforms:** All
- **Tags:** `docker`, `ux`, `stern`, `ctop`, `dockerize`, `portainer`, `netshoot`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official releases.
- **Usage:** Enabled by default; set `install_docker_ux: false` to opt-out. Set `install_portainer: true` or `install_netshoot: true` to enable those tools.

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

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| `install_docker_cli` | `true` | `false` | bool | opt-out | Installs Docker CLI | [tasks/docker-cli.yml](tasks/docker-cli.yml) |
| `install_docker_desktop` | `true` | `false` | bool | opt-out | Installs Docker Desktop/OrbStack | [tasks/docker-desktop.yml](tasks/docker-desktop.yml) |
| `install_dive` | `true` | `false` | bool | opt-out | Installs Dive image explorer | [tasks/dive.yml](tasks/dive.yml) |
| `install_docker_security` | `true` | `false` | bool | opt-out | Installs security tools | [tasks/docker-security.yml](tasks/docker-security.yml) |
| `install_clair` | `false` | `true` | bool | opt-in | Installs Clair container scanner | [tasks/docker-security.yml](tasks/docker-security.yml) |
| `install_docker_optimize` | `true` | `false` | bool | opt-out | Installs optimization tools | [tasks/docker-optimize.yml](tasks/docker-optimize.yml) |
| `install_docker_ux` | `true` | `false` | bool | opt-out | Installs UX tools | [tasks/docker-ux.yml](tasks/docker-ux.yml) |
| `install_portainer` | `false` | `true` | bool | opt-in | Installs Portainer web UI | [tasks/docker-ux.yml](tasks/docker-ux.yml) |
| `install_netshoot` | `false` | `true` | bool | opt-in | Installs Netshoot troubleshooting container | [tasks/docker-ux.yml](tasks/docker-ux.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, RedHat, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `yum` (RedHat), `brew` (macOS), `chocolatey` (Windows)

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.dev-docker
      vars:
        install_docker_cli: true
        install_docker_desktop: true
        install_dive: true
        install_docker_security: true
        install_clair: false
        install_docker_optimize: true
        install_docker_ux: true
        install_portainer: false
        install_netshoot: false
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
