# Ansible Role: levonk.user_setup.thick-shell

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/thick-shell)

This role installs and configures multiple advanced shell environments (Zsh, Bash, Fish, Nushell) and a suite of modern terminal tools for power users. It supports Linux, macOS, and Windows (WSL), and is designed for highly customizable, productive shell workspaces.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/user_setup/roles/thick-shell/tasks):

| Feature/Task                      | Description                                                           | Required Variable(s)                  | Source |
|-----------------------------------|-----------------------------------------------------------------------|---------------------------------------|--------|
| Set default shell stack           | Sets `thick_shells` list (defaults to `['zsh']`)                      | [`thick_shells`](#thick_shells)       | [tasks/main.yml](tasks/main.yml) |
| Ensure Nushell stack              | Installs/configures Nushell if requested                              | `thick_shells`                        | [tasks/shells/nushell.yml](tasks/shells/nushell.yml) |
| Ensure Zsh stack                  | Installs/configures Zsh and Oh My Zsh if requested                    | `thick_shells`                        | [tasks/shells/zsh.yml](tasks/shells/zsh.yml) |
| Ensure Bash stack                 | Installs/configures Bash if requested                                 | `thick_shells`                        | [tasks/shells/bash.yml](tasks/shells/bash.yml) |
| Ensure Fish stack                 | Installs/configures Fish if requested                                 | `thick_shells`                        | [tasks/shells/fish.yml](tasks/shells/fish.yml) |
| Windows Oh My Posh + Posh-Git     | Installs Oh My Posh and Posh-Git on Windows                           | N/A                                   | [tasks/shells/windows_posh.yml](tasks/shells/windows_posh.yml) |
| Install tmux                      | Installs tmux terminal multiplexer                                    | `thick_shell_install_tmux`            | [tasks/tools/tmux.yml](tasks/tools/tmux.yml) |
| Install zellij                    | Installs Zellij multiplexer                                           | `thick_shell_install_zellij`          | [tasks/tools/zellij.yml](tasks/tools/zellij.yml) |
| Install mosh                      | Installs Mosh remote shell                                            | `thick_shell_install_mosh`            | [tasks/tools/mosh.yml](tasks/tools/mosh.yml) |
| Install fzf                       | Installs fzf fuzzy finder                                             | `thick_shell_install_fzf`             | [tasks/tools/fzf.yml](tasks/tools/fzf.yml) |
| Install direnv                    | Installs direnv environment manager                                   | `thick_shell_install_direnv`          | [tasks/tools/direnv.yml](tasks/tools/direnv.yml) |
| Install ripgrep                   | Installs ripgrep search tool                                          | `thick_shell_install_ripgrep`         | [tasks/tools/ripgrep.yml](tasks/tools/ripgrep.yml) |
| Install bat                       | Installs bat syntax highlighter                                       | `thick_shell_install_bat`             | [tasks/tools/bat.yml](tasks/tools/bat.yml) |
| Install fd                        | Installs fd file finder                                               | `thick_shell_install_fd`              | [tasks/tools/fd.yml](tasks/tools/fd.yml) |
| Install zoxide                    | Installs zoxide smart cd                                              | `thick_shell_install_zoxide`          | [tasks/tools/zoxide.yml](tasks/tools/zoxide.yml) |
| Install Neovim                    | Installs Neovim and ensures config directory exists                   | `thick_shell_install_neovim`          | [tasks/tools/neovim.yml](tasks/tools/neovim.yml) |

---

## Detailed Feature Documentation

### Shell Stacks (Zsh, Bash, Fish, Nushell)
**Description:**
> Installs and configures each shell and its ecosystem (Oh My Zsh, completions, plugins) as requested. Defaults to Zsh if not specified.
- **Tags:** `thick_shell`, `zsh`, `bash`, `fish`, `nushell`
- **Usage:**
  - Set `thick_shells` to a list of desired shells.

### Advanced Terminal Tools
**Description:**
> Installs tmux, zellij, mosh, and modern CLI tools for productivity.
- **Tags:** `tmux`, `zellij`, `mosh`, `fzf`, `direnv`, `ripgrep`, `bat`, `fd`, `zoxide`, `neovim`
- **Idempotency:** Each tool is only installed if not present.
- **Usage:**
  - Set `thick_shell_install_*` variables to enable installation of each tool.

-   **tmux**: A popular terminal multiplexer.
-   **Zellij**: A modern, Rust-based terminal workspace and multiplexer.
-   **Mosh**: A remote terminal application that allows roaming and supports intermittent connectivity.
-   **fzf**: A command-line fuzzy finder with shell integration for history search and file navigation.

### Modern CLI Tools

-   **direnv**: Auto-load .envrc files per directory — great for managing secrets and environment variables.
-   **ripgrep**: Blazing-fast search tool that pairs beautifully with fzf.
-   **bat**: Syntax-highlighted cat replacement with Git integration.
-   **fd**: A simpler, faster alternative to find.
-   **zoxide**: A smarter cd command that learns your habits and lets you jump to frequently used directories.
-   **neovim**: Modern, extensible Vim-based text editor (`nvim`) with Lua plugin support. Installs on all platforms and ensures `~/.config/nvim` exists.

**Note**: On Windows, these tools are intended for use within the Windows Subsystem for Linux (WSL). The role will not install them on the native Windows host but will display a message advising to install them within WSL.

## Requirements

-   `winget` on Windows.
-   `homebrew` on macOS.
-   `apt` on Debian-based systems.
-   For **Zellij** on Debian, a working **Rust** development environment is required (e.g., via the `levonk.dev_setup.dev-rust` role).
-   For **Neovim**, Python 3 is recommended for advanced plugin support (not required for minimal usage).

## Role Variables

-   `shell_stack`: A list of shells to install. Defaults to `['zsh']`. Supported values are `zsh`, `bash`, `fish`.
-   `thick_shell_install_tmux`: Set to `true` to install tmux.
-   `thick_shell_install_zellij`: Set to `true` to install Zellij.
-   `thick_shell_install_mosh`: Set to `true` to install Mosh.
-   `thick_shell_install_fzf`: Set to `true` to install fzf fuzzy finder.
-   `thick_shell_install_direnv`: Set to `true` to install direnv environment manager.
-   `thick_shell_install_ripgrep`: Set to `true` to install ripgrep search tool.
-   `thick_shell_install_bat`: Set to `true` to install bat syntax highlighter.
-   `thick_shell_install_fd`: Set to `true` to install fd file finder.
-   `thick_shell_install_zoxide`: Set to `true` to install zoxide smart cd.
-   `thick_shell_install_neovim`: Set to `true` to install Neovim modern text editor.

## Dependencies

-   The `levonk.common.fonts` role is a dependency to ensure Nerd Fonts are available for shell themes.
-   The Zellij task requires a Rust environment on Debian systems.

## Example Playbook

To install the default Zsh stack along with all advanced tools:

```yaml
---
- hosts: workstations
  become: yes
  vars:
    thick_shell_install_tmux: true
    thick_shell_install_zellij: true
    thick_shell_install_fzf: true
    thick_shell_install_direnv: true
    thick_shell_install_ripgrep: true
    thick_shell_install_bat: true
    thick_shell_install_fd: true
    thick_shell_install_zoxide: true
    thick_shell_install_neovim: true
  roles:
    - role: levonk.user_setup.thick-shell
```

## Neovim

- Installs Neovim (`nvim`) on all supported platforms.
- Ensures the config directory `~/.config/nvim` exists.
- BDD and Testinfra tests verify:
  - Neovim is installed and runs (`nvim --version`, `nvim --headless +qall`)
  - Config directory exists
  - Editor launches and exits cleanly

See `doc/gherkin/features/neovim.feature` and `molecule/default/tests/test_neovim.py` for details.


## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.
