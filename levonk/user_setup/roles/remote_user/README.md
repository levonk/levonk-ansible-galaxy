# remote_user Role

This role configures a remote-access user account (e.g., for SSH or RDP) on the target system. It supports:
- User creation and configuration
- Secure remote access setup (SSH, RDP)
- Key/certificate management
- Session and access controls

## Variables
- `remote_user_name`: Username to create/configure
- `remote_user_ssh_keys`: List of authorized SSH keys
- `remote_user_rdp_enabled`: Enable RDP access (Windows)

## Compliance
- Enforces secure remote access defaults
- Supports CIS/NIST mapping

## Testing
- Molecule scenario included for remote access and security checks
