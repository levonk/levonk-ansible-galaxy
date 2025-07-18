# Ansible Role: levonk.common.fonts

Installs Nerd Fonts, which are essential for modern terminal themes like Powerlevel10k and Starship.

## Description

This role automates the installation of a common Nerd Font (FiraCode) on supported systems:

-   **Windows**: Uses `winget`.
-   **macOS**: Uses the `homebrew/cask-fonts` tap.
-   **Debian-based Linux**: Downloads the latest release from GitHub and installs it for the current user.

This role is intended to be used as a dependency for other roles that require Nerd Fonts.

## Requirements

-   `winget` on Windows.
-   `homebrew` on macOS.
-   `unzip` and `fontconfig` on Debian-based systems.

## Role Variables

None.

## Dependencies

None.

## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.
