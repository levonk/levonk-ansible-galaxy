# local_user Role

This role configures a local (non-remote, non-service) user account on the target system. It supports:
- User creation and configuration
- Password and SSH key management
- Local shell, group, and sudo settings
- Compliance and security controls

## Variables
- `local_user_name`: Username to create/configure
- `local_user_shell`: Shell for the user (default: `/bin/bash`)
- `local_user_groups`: List of groups
- `local_user_ssh_keys`: List of authorized SSH keys

## Compliance
- Enforces secure defaults and password/SSH key policies
- Supports CIS/NIST mapping

## Testing
- Molecule scenario included for idempotency and security checks
