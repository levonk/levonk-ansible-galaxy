# thick-shell: Multi-shell installer/configurator

This role installs and configures shells and frameworks for Linux, Mac, and Windows. Supports zsh (Oh My Zsh + PowerLevel10k), bash (bash-it + starship), fish (Oh My Fish + starship), and always installs Oh My Posh + Posh-Git on Windows.

## Usage

```yaml
- hosts: all
  roles:
    - role: thick-shell
      vars:
        thick_shells: ["zsh", "bash", "fish"]
```

- If `thick_shells` is not set, defaults to `["zsh"]`.
- Any subset or all can be specified.
- Windows always gets Oh My Posh + Posh-Git.

## Variables
- `thick_shells`: List of shells to install (`zsh`, `bash`, `fish`)

## Security/Portability
- Uses Ansible facts for OS/user detection
- No hardcoded paths

## License
MIT
