# Ansible Role: levonk.vibeops.dev_ai_assisted

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-ai-assisted)

This role provisions a comprehensive, cross-platform suite of AI-assisted developer tools, editors, and CLIs for Linux, macOS, and Windows. It follows strict best-practices documentation and variable usage conventions.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/vibeops/roles/dev-ai-assisted/tasks):

| Feature/Task                | Description                                            | Required Variable(s) | Source |
|-----------------------------|--------------------------------------------------------|----------------------|--------|
| Install Visual Studio Code  | Installs VSCode editor (cross-platform)                | N/A                 | [tasks/install_vscode.yml](tasks/install_vscode.yml) |
| Install Cursor              | Installs Cursor AI code editor (cross-platform)        | N/A                 | [tasks/install_cursor.yml](tasks/install_cursor.yml) |
| Install Warp                | Installs Warp AI terminal (macOS only)                | N/A                 | [tasks/install_warp.yml](tasks/install_warp.yml) |
| Install Google Cloud SDK    | Installs gcloud CLI (cross-platform)                   | N/A                 | [tasks/install_gcloud_sdk.yml](tasks/install_gcloud_sdk.yml) |
| Install Gemini CLI          | Installs Gemini CLI                                   | N/A                 | [tasks/install_gemini_cli.yml](tasks/install_gemini_cli.yml) |
| Install GitHub Copilot CLI  | Installs Copilot CLI for shell/code AI                | N/A                 | [tasks/copilot-cli.yml](tasks/copilot-cli.yml) |
| Install AWS CLI             | Installs AWS CLI                                      | N/A                 | [tasks/install_aws_cli.yml](tasks/install_aws_cli.yml) |
| Install Amazon Q            | Installs Amazon Q AI CLI                              | N/A                 | [tasks/install_amazon_q.yml](tasks/install_amazon_q.yml) |
| Install Cline               | Installs Cline AI CLI                                 | N/A                 | [tasks/install_cline.yml](tasks/install_cline.yml) |
| Install Windsurf            | Installs Windsurf CLI/agent                           | N/A                 | [tasks/install_windsurf.yml](tasks/install_windsurf.yml) |
| Install Kiro                | Installs Kiro AI CLI                                  | N/A                 | [tasks/install_kiro.yml](tasks/install_kiro.yml) |
| Install Claude Code Tools   | Installs Claude Code, Router, Proxy, and frameworks   | N/A                 | [tasks/claude-code/](tasks/claude-code/) |
| Install Tmux-Orchestrator   | Installs terminal session manager                     | N/A                 | [tasks/tmux/install_orchestrator.yml](tasks/tmux/install_orchestrator.yml) |

---

## Detailed Feature Documentation

### Install Visual Studio Code
**Description:** Installs VSCode via Homebrew (macOS), Winget (Windows), or apt (Debian/Ubuntu). Adds repo and GPG keys where required.
- **Supported Platforms:** Windows, MacOS, Debian
- **Tags:** `editor`, `vscode`, `ai`, `dev`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official sources.
- **Usage:** Enabled by default; no variables needed.

### Install Cursor
**Description:** Installs Cursor editor via Homebrew (macOS), Winget (Windows), or .deb package (Debian/Ubuntu).
- **Supported Platforms:** Windows, MacOS, Debian
- **Tags:** `editor`, `cursor`, `ai`, `dev`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official sources.
- **Usage:** Enabled by default; no variables needed.

### Install Warp
**Description:** Installs Warp terminal via Homebrew (macOS only).
- **Supported Platforms:** MacOS
- **Tags:** `terminal`, `warp`, `ai`, `dev`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official sources.
- **Usage:** Enabled by default; no variables needed.

### Install Google Cloud SDK
**Description:** Installs gcloud CLI via Homebrew (macOS), Chocolatey (Windows), or apt (Debian/Ubuntu).
- **Supported Platforms:** Windows, MacOS, Debian
- **Tags:** `cloud`, `gcp`, `gcloud`, `cli`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official sources.
- **Usage:** Enabled by default; no variables needed.

### Install GitHub Copilot CLI
**Description:** Installs Copilot CLI globally via npm. Ensures Node.js and npm are present (auto-includes dev-node role if not).
- **Supported Platforms:** All
- **Tags:** `copilot`, `ai`, `cli`, `dev`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Uses only official sources.
- **Usage:** Enabled by default; no variables needed.

### Claude Code Tools
**Description:** Installs a suite of Claude AI development tools including:
- Claude Code (npm package)
- Claude Code Router
- Claude Code Proxy
- CodeMCP (Claude Code Multi-Prompt)
- SuperClaude Framework
- Awesome Claude Prompts
- Awesome AI System Prompts
- Awesome Claude Code Resources

- **Supported Platforms:** All with Node.js
- **Tags:** `claude`, `ai`, `code`, `dev`
- **Dependencies:** Node.js, npm
- **Idempotency:** Each tool checks for existing installation
- **Security:** Uses official sources and verifies checksums
- **Usage:** Enabled by default; no variables needed

### Tmux-Orchestrator
**Description:** Installs a terminal session manager for managing multiple terminal sessions.
- **Supported Platforms:** Linux, macOS
- **Tags:** `tmux`, `terminal`, `dev`
- **Dependencies:** tmux
- **Idempotency:** Safe to run repeatedly
- **Security:** Uses official package managers
- **Usage:** Enabled by default; no variables needed

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
| *(none by default)* |         |              |      |            |         |         |

---

### Requirements
- Ansible 2.9+
- Python 3.6+
- Supported platforms: Debian, Ubuntu, RedHat, MacOSX, Windows
- Platform-specific: `apt` (Debian/Ubuntu), `brew` (macOS), `winget` (Windows)

---

### Dependencies
- None

---

### Example Playbooks
```yaml
- hosts: all
  become: yes
  roles:
    - role: levonk.vibeops.dev_ai_assisted
```

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.


