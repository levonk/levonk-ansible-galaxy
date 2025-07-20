# levonk.common.package

A secure, cross-platform, idempotent Ansible role for package management.

- Supports Windows (WinGet/Chocolatey), macOS (Homebrew), Linux (apt)
- Handles repo/tool installation, upgrades, stateful caching, and post-install verification
- Forwards all `ansible.builtin.package` variables, plus enhanced checksum/caching
- Robust error handling, actionable logging, and compliance TODOs
- Designed/tested with BDD/TDD and >80% test coverage

## Features
- Unified package management for all major OSes
- Secure, stateful update/upgrade logic with caching
- Post-install verification and error handling
- Compliance hooks for third-party and licensing-sensitive ops
- Fully tested with Molecule and BDD scenarios

## Usage
```yaml
- name: Install package securely
  include_role:
    name: levonk.common.package
  vars:
    name: "curl"
    state: "latest"
```

## Variables
- `name`: Package name (required)
- `state`: present/latest/absent (default: present)
- `update_cache`: Force update/upgrade (default: false)
- `checksum`: Optional checksum for installer validation
- `checksum_url`: Optional URL for checksum retrieval
- `levonk_package_cache_file`: Path for stateful cache (default: /var/tmp/levonk_package_cache.json)
- `levonk_package_manager`: Override manager (auto/winget/choco/brew/apt)
- `levonk_package_cache_expiry_minutes`: Cache expiry (default: 60)

## Migration Notes
- Replace direct use of `ansible.builtin.package` with this role for enhanced security, compliance, and cross-platform support.
- See internal-docs/prompts/feature-updated-ansible-builtin-package.md for migration details.

## Compliance
- All third-party and licensing-sensitive operations are marked with `// TODO: Compliance`.
- Compliance tests are present in BDD features.
- See global rules for compliance, security, and legal requirements.

## Testing
- BDD `.feature` files and Molecule scenarios cover all major paths:
  - Success, fallback, security, compliance, and error scenarios for all platforms
- >80% code coverage required

## TDD/BDD
- Failing tests are written before code.
- Each `.feature` is fully tested and implemented before the next.
- See tests/features/package_management.feature for scenarios.

## Authors
- Brillarc, LLC

---
// TODO: Compliance — review all third-party and licensing-sensitive code paths.
