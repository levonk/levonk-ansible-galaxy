# Ansible Role: levonk.vibeops.dev-js

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-js)

This role sets up a cross-platform JavaScript development environment, installing Node.js, npm, JavaScript package managers, linters, formatters, and build tools. Documentation follows strict best-practices boilerplate.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-js/tasks):

| Feature/Task                      | Description                                 | Required Variable(s)                | Source |
|-----------------------------------|---------------------------------------------|-------------------------------------|--------|
| Install Node.js and npm           | Installs Node.js and npm on all platforms   | [`dev_js_install_nodejs`](#dev_js_install_nodejs) | [tasks/nodejs.yml](tasks/nodejs.yml) |
| Install fnm (Fast Node Manager)   | Installs fnm for Node.js version management | [`dev_js_install_fnm`](#dev_js_install_fnm)       | [tasks/js-managers.yml](tasks/js-managers.yml) |
| Install pnpm                      | Installs pnpm globally                      | [`dev_js_install_pnpm`](#dev_js_install_pnpm)     | [tasks/js-managers.yml](tasks/js-managers.yml) |
| Install yarn                      | Installs yarn globally                      | [`dev_js_install_yarn`](#dev_js_install_yarn)     | [tasks/js-managers.yml](tasks/js-managers.yml) |
| Install ESLint                    | Installs ESLint globally                    | [`dev_js_install_eslint`](#dev_js_install_eslint) | [tasks/js-linters.yml](tasks/js-linters.yml) |
| Install Prettier                  | Installs Prettier globally                  | [`dev_js_install_prettier`](#dev_js_install_prettier) | [tasks/js-formatters.yml](tasks/js-formatters.yml) |
| Install TypeScript                | Installs TypeScript globally                | [`dev_js_install_typescript`](#dev_js_install_typescript) | [tasks/js-build-tools.yml](tasks/js-build-tools.yml) |
| Install Vite                      | Installs Vite globally                      | [`dev_js_install_vite`](#dev_js_install_vite)     | [tasks/js-build-tools.yml](tasks/js-build-tools.yml) |
| Install Create React App           | Installs create-react-app globally          | [`dev_js_install_create_react_app`](#dev_js_install_create_react_app) | [tasks/js-build-tools.yml](tasks/js-build-tools.yml) |

---

## Detailed Feature Documentation

### Install Node.js and npm
**Description:** Installs Node.js and npm using the system package manager or Windows tools.
- **Supported Platforms:** Debian, Ubuntu, RedHat, MacOSX, Windows
- **Tags:** `dev`, `js`, `nodejs`, `npm`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official repositories and trusted sources.
- **Usage:** Controlled by `dev_js_install_nodejs` (opt-out, enabled by default).

### Install fnm (Fast Node Manager)
**Description:** Installs fnm for Node.js version management.
- **Supported Platforms:** Debian, Ubuntu, RedHat, MacOSX, Windows
- **Tags:** `dev`, `js`, `fnm`, `nodejs`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses official install script or package manager.
- **Usage:** Controlled by `dev_js_install_fnm` (opt-out, enabled by default).

### Install pnpm
a> Installs pnpm globally using npm.
- **Supported Platforms:** All
- **Tags:** `dev`, `js`, `pnpm`, `nodejs`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses npm global install.
- **Usage:** Controlled by `dev_js_install_pnpm` (opt-out, enabled by default).

### Install yarn
a> Installs yarn globally using corepack or npm.
- **Supported Platforms:** All
- **Tags:** `dev`, `js`, `yarn`, `nodejs`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses npm global install or corepack.
- **Usage:** Controlled by `dev_js_install_yarn` (opt-out, enabled by default).

### Install ESLint
a> Installs ESLint globally using npm.
- **Supported Platforms:** All
- **Tags:** `dev`, `js`, `eslint`, `linter`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses npm global install.
- **Usage:** Controlled by `dev_js_install_eslint` (opt-out, enabled by default).

### Install Prettier
a> Installs Prettier globally using npm.
- **Supported Platforms:** All
- **Tags:** `dev`, `js`, `prettier`, `formatter`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses npm global install.
- **Usage:** Controlled by `dev_js_install_prettier` (opt-out, enabled by default).

### Install TypeScript
a> Installs TypeScript globally using npm.
- **Supported Platforms:** All
- **Tags:** `dev`, `js`, `typescript`, `build-tool`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses npm global install.
- **Usage:** Controlled by `dev_js_install_typescript` (opt-out, enabled by default).

### Install Vite
a> Installs Vite globally using npm.
- **Supported Platforms:** All
- **Tags:** `dev`, `js`, `vite`, `build-tool`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses npm global install.
- **Usage:** Controlled by `dev_js_install_vite` (opt-out, enabled by default).

### Install Create React App
a> Installs create-react-app globally using npm.
- **Supported Platforms:** All
- **Tags:** `dev`, `js`, `create-react-app`, `build-tool`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses npm global install.
- **Usage:** Controlled by `dev_js_install_create_react_app` (opt-out, enabled by default).

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
| <a name="dev_js_install_nodejs"></a>`dev_js_install_nodejs` | `true` | `false` | bool | opt-out | Install Node.js and npm | [tasks/nodejs.yml](tasks/nodejs.yml) |
| <a name="dev_js_install_fnm"></a>`dev_js_install_fnm` | `true` | `false` | bool | opt-out | Install fnm (Fast Node Manager) | [tasks/js-managers.yml](tasks/js-managers.yml) |
| <a name="dev_js_install_pnpm"></a>`dev_js_install_pnpm` | `true` | `false` | bool | opt-out | Install pnpm globally | [tasks/js-managers.yml](tasks/js-managers.yml) |
| <a name="dev_js_install_yarn"></a>`dev_js_install_yarn` | `true` | `false` | bool | opt-out | Install yarn globally | [tasks/js-managers.yml](tasks/js-managers.yml) |
| <a name="dev_js_install_typescript"></a>`dev_js_install_typescript` | `true` | `false` | bool | opt-out | Install TypeScript globally | [tasks/js-build-tools.yml](tasks/js-build-tools.yml) |
| <a name="dev_js_install_eslint"></a>`dev_js_install_eslint` | `true` | `false` | bool | opt-out | Install ESLint globally | [tasks/js-linters.yml](tasks/js-linters.yml) |
| <a name="dev_js_install_prettier"></a>`dev_js_install_prettier` | `true` | `false` | bool | opt-out | Install Prettier globally | [tasks/js-formatters.yml](tasks/js-formatters.yml) |
| <a name="dev_js_install_vite"></a>`dev_js_install_vite` | `true` | `false` | bool | opt-out | Install Vite globally | [tasks/js-build-tools.yml](tasks/js-build-tools.yml) |
| <a name="dev_js_install_create_react_app"></a>`dev_js_install_create_react_app` | `true` | `false` | bool | opt-out | Install create-react-app globally | [tasks/js-build-tools.yml](tasks/js-build-tools.yml) |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, RedHat, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `yum` (RedHat), `brew` (MacOSX), `chocolatey` (Windows)

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.dev-js
      vars:
        dev_js_install_nodejs: true
        dev_js_install_fnm: true
        dev_js_install_pnpm: true
        dev_js_install_yarn: true
        dev_js_install_typescript: true
        dev_js_install_eslint: true
        dev_js_install_prettier: true
        dev_js_install_vite: true
        dev_js_install_create_react_app: true
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
