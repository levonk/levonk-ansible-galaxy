# Role: open_firewall_port

Open a firewall port for a new local service, cross-platform and idempotent.

## Supported Firewalls
- UFW (Debian/Ubuntu)
- firewalld (RedHat/Fedora/CentOS)
- pf (macOS)
- Windows Defender Firewall

## Variables
- `open_firewall_port_port` (**required**): Port to open (e.g. 8080)
- `open_firewall_port_proto`: Protocol (tcp/udp, default: tcp)
- `open_firewall_port_service`: Service description for rule comments (default: "local service")

## Example Usage
```yaml
- hosts: all
  roles:
    - role: levonk.common.open_firewall_port
      vars:
        open_firewall_port_port: 8080
        open_firewall_port_proto: tcp
        open_firewall_port_service: "myapp"
```

## Idempotency & Safety
- Tasks only run if the firewall is installed and enabled.
- macOS: Appends rule to `/etc/pf.conf` and reloads pf.
- Windows: Creates a named inbound rule.

## Testing
- Molecule scenario: `molecule/default/`
- Gherkin feature: see requirements/gherkin/open_firewall_port.feature

## License
See LICENSE file.
