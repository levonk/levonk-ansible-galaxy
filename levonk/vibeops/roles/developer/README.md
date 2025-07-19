# Ansible Role: developer

This role configures a developer's environment with essential tools and settings to improve productivity and ensure consistency across different operating systems.

## Requirements

- For Windows targets, `ansible.windows.win_regedit` is used.
- For installing `super-linter`, `npm` is required on the target machine.
- For installing `universal-ctags`, a supported package manager (e.g., `apt`, `choco`, `brew`) is required.
- For installing `yq`, a supported package manager (Chocolatey, apt, or Homebrew) is required.
- For installing `yamlfmt`, Go must be installed on the target machine.

## Role Variables

There are no role-specific variables at this time.

## Dependencies

This role has no direct dependencies on other roles.

## Example Playbook

Here is an example of how to use this role in a playbook:

```yaml
- hosts: all
  roles:
    - role: levonk.vibeops.developer
```

## Features

This role implements the following features:

### Windows-Specific Configuration

- **Enables Long Filename Support**: Modifies the `HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem` registry key to allow long file paths.
- **Disables Sticky Keys**: Modifies the `HKCU:\Control Panel\Accessibility\StickyKeys` registry key to turn off the Sticky Keys feature.

### Cross-Platform Tools

- **Universal Ctags**: Installs `universal-ctags` using the system's native package manager.
- **Super Linter**: Installs `super-linter` globally using `npm`.
- **yq YAML Processor**: Installs `yq` for YAML processing using the system's native package manager (Chocolatey on Windows, apt on Debian/Ubuntu, Homebrew on macOS).
- **yamlfmt YAML Formatter**: Installs Google's `yamlfmt` for YAML formatting using `go install` (requires Go to be installed).

## License

Brillarc, LLC

## Author Information

This role was created by an AI assistant from Windsurf as part of the VibeOps ecosystem for Levon K.
