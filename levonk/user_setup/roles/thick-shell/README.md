# Ansible Role: levonk.user_setup.thick-shell

Installs and configures various shell environments (Zsh, Bash, Fish) and advanced terminal tools like tmux, Zellij, Mosh, fzf, and modern CLI utilities.

## Description

This role is designed to create a "thick shell" environment for power users. It handles the installation of different shells, shell frameworks (like Oh My Zsh), and essential command-line utilities across Windows, macOS, and Debian-based systems. It also installs terminal multiplexers and a remote shell to enhance productivity.

### Supported Shells

-   **Zsh**: Installs Zsh and the Oh My Zsh framework.
-   **Bash**: Installs Bash (where applicable) and basic configurations.
-   **Fish**: Installs the Fish shell.

### Advanced Terminal Tools

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
