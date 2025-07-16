# service_user Role

This role configures a non-interactive service account for running background processes or services. It supports:
- User/service account creation
- No shell or restricted shell
- Minimal privileges
- Systemd/service integration

## Variables
- `service_user_name`: Username to create/configure
- `service_user_groups`: List of groups
- `service_user_shell`: Shell (default: `/usr/sbin/nologin`)

## Compliance
- Enforces minimal privilege and non-interactive defaults
- Supports CIS/NIST mapping

## Testing
- Molecule scenario included for privilege and isolation checks
