# Windows Symlink Support

This module enables symbolic link support on Windows systems. It configures the necessary settings to allow the creation of symbolic links, which is particularly useful for development environments and certain application requirements.

## Requirements

- Windows 10/11 or Windows Server 2016+
- Administrator privileges
- Developer Mode enabled (will be configured automatically)

## Features

- Enables Developer Mode on Windows (required for symlink creation)
- Configures necessary permissions for the current user
- Provides example tasks for creating symbolic links
- Includes test cases to verify functionality

## Usage

### Basic Usage

Include the role in your playbook:

```yaml
- name: Configure Windows with symlink support
  hosts: windows_servers
  roles:
    - role: levonk.base_system
      tags: ['windows', 'symlink']
```

### Creating Symbolic Links

Use the `win_file` module to create symbolic links:

```yaml
- name: Create a symbolic link
  win_file:
    src: C:\path\to\source
    dest: C:\path\to\link
    state: link
```

## Testing

Run the included test playbook to verify symlink functionality:

```bash
ansible-playbook tests/windows/test_symlinks.yml -i your_inventory_file
```

## Notes

- A system restart may be required after enabling Developer Mode
- The user account must have the "Create symbolic links" privilege
- Some Windows editions may have additional restrictions on symlink creation

## Tags

- `windows` - All Windows-specific tasks
- `symlink` - Tasks related to symlink configuration
- `developer_mode` - Tasks that configure Windows Developer Mode
