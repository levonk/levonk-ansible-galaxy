# Role: `{{ role_name }}`

## Description

{{ role_description }}

## Requirements

- Ansible {{ min_ansible_version | default('2.9+') }}
- Python {{ min_python_version | default('3.6+') }}
- Other requirements...

## Role Variables

### Required Variables

| Variable | Type | Description |
|----------|------|-------------|
| `required_var` | string | Description of required variable |

### Optional Variables with Defaults

| Variable | Default | Description |
|----------|---------|-------------|
| `example_var` | `default_value` | Description of variable |

## Dependencies

- List any dependencies here
- Or `None` if none

## Example Playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: {{ role_name }}
      required_var: value
      example_var: custom_value
```

## License

{{ license | default('MIT') }}

## Author Information

{{ author | default('Your Name') }}

---
*Document generated on: {{ "now" | strftime("%Y-%m-%d") }}*  
*Version: {{ collection_version | default('1.0.0') }}*

Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
