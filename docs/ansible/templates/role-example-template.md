# {{ role_name }} - Examples

> **Note**: This document provides usage examples for the `{{ role_name }}` role.
> For general information, see the [README.md](README.md) file.

## Table of Contents
- [Basic Example](#basic-example)
- [Common Use Cases](#common-use-cases)
- [Advanced Configuration](#advanced-configuration)
- [Integration Examples](#integration-examples)
- [Troubleshooting](#troubleshooting)

## Basic Example

```yaml
# site.yml
- name: Basic {{ role_name }} usage
  hosts: all
  become: true
  roles:
    - role: {{ role_name }}
      # Required variables
      required_parameter: value
      
      # Common configuration
      example_setting: enabled
      another_setting: 42
```

## Common Use Cases

### Use Case 1: Basic Configuration

```yaml
# group_vars/all/{{ role_name }}.yml
{{ role_name }}_config:
  setting1: value1
  setting2: value2
  enabled: true
```

### Use Case 2: Conditional Execution

```yaml
# playbook.yml
- name: Conditional role execution
  hosts: all
  tasks:
    - name: Include {{ role_name }} role
      include_role:
        name: {{ role_name }}
      when: some_condition | bool
      vars:
        custom_setting: custom_value
```

## Advanced Configuration

### Custom Templates

```yaml
# group_vars/all/{{ role_name }}.yml
{{ role_name }}_templates:
  - src: templates/custom.conf.j2
    dest: /etc/{{ role_name }}/custom.conf
    owner: root
    group: root
    mode: '0644'
```

### Dependencies and Pre/Post Tasks

```yaml
# meta/main.yml
dependencies:
  - role: common
    vars:
      required_by_{{ role_name }}: true

# tasks/main.yml
- name: Pre-{{ role_name }} setup
  debug:
    msg: "Running pre-setup tasks"
  tags: always

- include_tasks: install.yml
- include_tasks: configure.yml

- name: Post-{{ role_name }} tasks
  debug:
    msg: "Running post-installation tasks"
  tags: always
```

## Integration Examples

### With Other Roles

```yaml
# site.yml
- name: Full deployment with {{ role_name }}
  hosts: all
  become: true
  roles:
    - role: common
    - role: {{ role_name }}
    - role: monitoring
      when: enable_monitoring | default(true) | bool
```

### With Tags

```bash
# Run only {{ role_name }} tasks
ansible-playbook site.yml --tags "{{ role_name }}"

# Skip {{ role_name }} tasks
ansible-playbook site.yml --skip-tags "{{ role_name }}"
```

## Troubleshooting

### Common Issues

1. **Issue**: Role fails with permission denied
   **Solution**: Ensure the playbook is running with `become: true` or appropriate privileges

2. **Issue**: Variable not found
   **Solution**: Verify the variable is defined in the correct scope (host_vars, group_vars, or playbook)

### Debugging

To debug the role, run with verbose output:

```bash
ansible-playbook site.yml -vvv --tags "{{ role_name }}"
```

### Getting Help

For additional help, please:
1. Check the [README.md](README.md) file
2. Review the role's documentation
3. Open an issue in the repository

---
*Document generated on: {{ "now" | strftime("%Y-%m-%d") }}*  
*Version: {{ collection_version | default('1.0.0') }}*

Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
