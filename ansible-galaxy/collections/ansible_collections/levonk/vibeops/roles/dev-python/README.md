# Ansible Role: levonk.vibeops.dev-python

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-python)

This role sets up a cross-platform Python development environment, supporting Python installation, version management, virtual environments, and modern Python dependency managers. Documentation follows strict best-practices boilerplate.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-python/tasks):

| Feature/Task                | Description                                   | Required Variable(s)         | Source |
|-----------------------------|-----------------------------------------------|------------------------------|--------|
| Install Python (multi-OS)   | Installs Python using pyenv, system pkg, or Chocolatey | python_versions (optional)   | [tasks/python.yml](tasks/python.yml) |
| Install pyenv               | Installs pyenv for Python version management  | install_pyenv (opt-in)       | [tasks/pyenv.yml](tasks/pyenv.yml) |
| Install virtualenv          | Installs virtualenv for environment creation  | install_virtualenv (opt-in)  | [tasks/virtualenv.yml](tasks/virtualenv.yml) |
| Install virtualenvwrapper   | Installs and configures virtualenvwrapper     | install_virtualenvwrapper (opt-in) | [tasks/virtualenvwrapper.yml](tasks/virtualenvwrapper.yml) |
| Install Miniconda           | Installs Miniconda Python distribution        | install_miniconda (opt-in)   | [tasks/miniconda.yml](tasks/miniconda.yml) |
| Install Poetry              | Installs Poetry dependency manager            | install_poetry (opt-out)     | [tasks/poetry.yml](tasks/poetry.yml) |
| Install Pipenv              | Installs Pipenv dependency manager            | install_pipenv (opt-in)      | [tasks/pipenv.yml](tasks/pipenv.yml) |
| Install PDM                 | Installs PDM dependency manager               | install_pdm (opt-in)         | [tasks/pdm.yml](tasks/pdm.yml) |
| Install UV                  | Installs UV (fast pip replacement)            | install_uv (opt-in)          | [tasks/uv.yml](tasks/uv.yml) |
| Install dev tools           | Installs dev tools (black, flake8, pytest)    | dev_python_tools (optional)  | [tasks/python.yml](tasks/python.yml) |

---

## Detailed Feature Documentation

### Install Python (multi-OS)
**Description:** Installs Python using pyenv (preferred), system package manager, or Chocolatey (Windows). Supports multiple versions.
- **Supported Platforms:** Debian, Ubuntu, RedHat, MacOSX, Windows
- **Tags:** `python`, `sdk`, `dev`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official repositories or trusted installers.
- **Usage:** Controlled by `python_versions` and `install_pyenv` variables.

### Install pyenv
**Description:** Installs pyenv for Python version management on UNIX-like systems.
- **Supported Platforms:** Debian, Ubuntu, RedHat, MacOSX
- **Tags:** `pyenv`, `dev`, `python`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs from official sources.
- **Usage:** Set `install_pyenv: true` to enable.

### Install virtualenv
**Description:** Installs virtualenv and creates a default environment.
- **Supported Platforms:** All except Windows
- **Tags:** `virtualenv`, `python`, `env`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs via package or pip.
- **Usage:** Set `install_virtualenv: true` to enable.

### Install virtualenvwrapper
**Description:** Installs and configures virtualenvwrapper for UNIX or virtualenvwrapper-win for Windows.
- **Supported Platforms:** All
- **Tags:** `virtualenvwrapper`, `python`, `env`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs via pip or win_pip.
- **Usage:** Set `install_virtualenvwrapper: true` to enable.

### Install Miniconda
**Description:** Installs Miniconda Python distribution.
- **Supported Platforms:** All
- **Tags:** `miniconda`, `python`, `env`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs from official Anaconda sources.
- **Usage:** Set `install_miniconda: true` to enable.

### Install Poetry
**Description:** Installs Poetry dependency manager for Python.
- **Supported Platforms:** All
- **Tags:** `poetry`, `python`, `deps`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs from trusted sources.
- **Usage:** Enabled by default; set `install_poetry: false` to disable.

### Install Pipenv
**Description:** Installs Pipenv dependency manager for Python.
- **Supported Platforms:** All
- **Tags:** `pipenv`, `python`, `deps`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs via package, pip, or pipx.
- **Usage:** Set `install_pipenv: true` to enable.

### Install PDM
**Description:** Installs PDM dependency manager for Python.
- **Supported Platforms:** All
- **Tags:** `pdm`, `python`, `deps`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs via package, pip, or official script.
- **Usage:** Set `install_pdm: true` to enable.

### Install UV
**Description:** Installs UV, a fast pip replacement.
- **Supported Platforms:** All
- **Tags:** `uv`, `python`, `deps`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs via package or official script.
- **Usage:** Set `install_uv: true` to enable.

### Install dev tools
**Description:** Installs Python dev tools (black, flake8, pytest).
- **Supported Platforms:** All except Windows
- **Tags:** `dev`, `python`, `tools`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Installs via package manager.
- **Usage:** Controlled by `dev_python_tools` variable.

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
| `python_versions` | `["3.11.0", "3.9.0"]` | `["3.10.5"]` | list | optional | Python versions to install | [tasks/python.yml](tasks/python.yml) |
| `install_pyenv` | `false` | `true` | bool | opt-in | Install pyenv for version management | [tasks/pyenv.yml](tasks/pyenv.yml) |
| `install_virtualenv` | `false` | `true` | bool | opt-in | Install virtualenv | [tasks/virtualenv.yml](tasks/virtualenv.yml) |
| `install_virtualenvwrapper` | `false` | `true` | bool | opt-in | Install virtualenvwrapper | [tasks/virtualenvwrapper.yml](tasks/virtualenvwrapper.yml) |
| `install_miniconda` | `false` | `true` | bool | opt-in | Install Miniconda | [tasks/miniconda.yml](tasks/miniconda.yml) |
| `install_poetry` | `true` | `false` | bool | opt-out | Install Poetry | [tasks/poetry.yml](tasks/poetry.yml) |
| `install_pipenv` | `false` | `true` | bool | opt-in | Install Pipenv | [tasks/pipenv.yml](tasks/pipenv.yml) |
| `install_pdm` | `false` | `true` | bool | opt-in | Install PDM | [tasks/pdm.yml](tasks/pdm.yml) |
| `install_uv` | `false` | `true` | bool | opt-in | Install UV | [tasks/uv.yml](tasks/uv.yml) |
| `dev_python_tools` | `["black", "flake8", "pytest"]` | `["black"]` | list | optional | List of dev tools to install | [tasks/python.yml](tasks/python.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, RedHat, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `dnf` (RedHat), `chocolatey` (Windows)

---

### Dependencies
- levonk.vibeops.dev-cloud

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.dev-python
      vars:
        python_versions: ["3.10.5"]
        install_pyenv: true
        install_virtualenv: true
        install_virtualenvwrapper: true
        install_miniconda: false
        install_poetry: true
        install_pipenv: false
        install_pdm: false
        install_uv: false
        dev_python_tools: ["black", "flake8"]
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

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.
