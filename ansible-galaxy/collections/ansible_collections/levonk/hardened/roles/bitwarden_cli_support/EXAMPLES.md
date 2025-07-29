# Bitwarden CLI Support Role — Usage Examples

## Basic Role Usage
```yaml
- hosts: all
  roles:
    - role: levonk.hardened.bitwarden-cli-support
```

## Install Only Official Bitwarden CLI (bw)
```yaml
- hosts: all
  roles:
    - role: levonk.hardened.bitwarden-cli-support
      vars:
        bitwarden_tools: ["bw"]
```

## Install All Supported Tools
```yaml
- hosts: all
  roles:
    - role: levonk.hardened.bitwarden-cli-support
      vars:
        bitwarden_tools: ["bw", "bws", "rbw"]
```

## Example with Custom Install Path (if supported)
```yaml
- hosts: all
  roles:
    - role: levonk.hardened.bitwarden-cli-support
      vars:
        bitwarden_install_path: "/usr/local/bin"
```
