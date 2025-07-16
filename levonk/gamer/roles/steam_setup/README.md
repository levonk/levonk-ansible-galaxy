# steam_setup Role

This role automates the installation and configuration of Steam for gaming systems. It supports:
- Steam installation (Linux, Windows)
- User/group setup for Steam
- Optional game library management

## Variables
- `steam_user_name`: Username to associate with Steam
- `steam_install_dir`: Installation directory

## Compliance
- Follows secure install practices
- Optional: parental controls, network restrictions

## Testing
- Molecule scenario included for install and config checks
