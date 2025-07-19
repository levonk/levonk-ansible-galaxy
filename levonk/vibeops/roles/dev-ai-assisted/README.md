# Ansible Role: dev-ai-assisted

This role provisions a comprehensive suite of AI-assisted development tools on a target workstation, designed to accelerate coding, testing, and operational workflows.

## Features

This role installs and configures the following AI-powered tools:

- **Core IDEs & Terminals:**
  - Visual Studio Code
  - Windsurf
  - Cursor
  - Warp (macOS only)

- **AI Command-Line Interfaces (CLIs):**
  - Gemini CLI
  - Amazon Q for command line
  - Cline

- **Claude & Experimental Tooling:**
  - Kiro
  - Claude Code
  - Claude Code Router
  - Claude Taskmaster
  - RooCode + Boomerang Mode

*Note: Installation support for some tools is currently in development and may be provided via placeholder tasks.*

## Requirements

- **Supported OS:**
  - macOS
  - Windows 10/11
  - Linux (Debian-based distributions)
- **Package Managers:**
  - Homebrew is required for macOS.
  - Winget is required for Windows.
  - `apt` is used for Debian-based systems.
- **Development Tools:**
  - Go is required for claude-code-router installation.
  - Node.js/npm is required for Claude Code installation.
- **Collections:** The `community.general` and `ansible.windows` collections are used.

## Usage Example

To use this role, simply include it in your main playbook:

```yaml
- hosts: all
  roles:
    - role: levonk.vibeops.dev-ai-assisted
```

## License

AGPL-3.0-only

## Author

levonk
