# Bitwarden CLI Support Role

This Ansible role installs and manages Bitwarden CLI tools (`bw`, `bws`, `rbw`) in a secure, OS-portable, and compliance-ready way. It is part of the `levonk.hardened` collection.

## Features
- Installs official Bitwarden CLI (`bw`), Bitwarden Secrets CLI (`bws`), and Rust Bitwarden CLI (`rbw`)
- OS-specific installation (Debian, Windows, macOS/Darwin)
- Uses `levonk.common.package` for package management when possible, falls back to secure HTTPS downloads
- Modular, maintainable tasks per tool and per OS
- Molecule scenario for automated testing
- BDD Gherkin feature for compliance and acceptance
- Inline documentation and license headers
- Fails gracefully on unsupported OS

## Usage Example
```yaml
- hosts: all
  roles:
    - role: levonk.hardened.bitwarden-cli-support
```

## Testing
- Molecule scenario provided: `molecule test`
- Gherkin feature for BDD: see `docs/requirements/gherkin/bitwarden_cli.feature`

## License
Copyright (c) Levon K. Licensed under the project license.
