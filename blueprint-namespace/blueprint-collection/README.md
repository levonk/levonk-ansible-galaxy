# {{ collection_name }} Collection

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/blueprint-namespace/blueprint-collection)

{{ collection_description }}

---

## Overview

This Ansible collection provides reusable roles, modules, and plugins for system configuration, automation, and best-practices infrastructure management. It is designed for maintainability, clarity, and ease of contribution.

---

## Features & Included Content

### Roles

| Name         | Description                      | Major Features/Tasks                | Docs |
|--------------|----------------------------------|-------------------------------------|------|
| base_system  | Core system configuration        | Hostname, timezone, NTP, packages   | [README](roles/base_system/README.md) |
| blueprint-role | Example/documentation template  | Boilerplate for new roles, docs     | [README](roles/blueprint-role/README.md) |
| ...          | ...                              | ...                                 | ...  |

### Modules

| Name         | Description                      | Key Parameters                      | Docs |
|--------------|----------------------------------|-------------------------------------|------|
| my_module    | Does X, Y, Z                     | foo, bar, baz                       | [doc](plugins/modules/my_module.py) |
| ...          | ...                              | ...                                 | ...  |

---

## Usage

### Dependencies


---

### Example: Using Multiple Roles

```yaml
- hosts: all
  collections:
    - {{ collection_namespace }}.{{ collection_name }}
  roles:
    - base_system
    - blueprint-role
  vars:
    system_hostname: myhost
    timezone: "America/Los_Angeles"
    base_system_packages:
      - vim
      - curl
      - git
```

### Example: Using a Module

```yaml
- name: Do something
  {{ collection_namespace }}.{{ collection_name }}.my_module:
    foo: bar
```

### Advanced Usage Patterns
- Use tags to selectively enable features (see role READMEs for tag docs)
- Override variables at play, host, or group level for flexible configuration
- Reference [role READMEs](roles/) for full variable tables, activation enums, and advanced examples

---

### Requirements

- Ansible {{ min_ansible_version | default('2.9+') }}
- Python {{ min_python_version | default('3.6+') }}
- Supported platforms: Linux, macOS, Windows (see individual roles for details)
- Additional requirements may apply per role/module

---

## Testing

- Molecule scenarios: see `roles/<role>/molecule/`
- ansible-test: `ansible-test integration`
- Linting: `ansible-lint`

```bash
# Install test requirements
pip install -r requirements-test.txt

# Run tests
ansible-test integration
```

---

## Best Practices for Collection Maintenance

- **Document every variable and parameter** in included roles/modules using tables with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- **Link to the source** of each feature/task and variable usage for transparency and maintainability.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Reference external specs or requirements** where relevant.
- **Keep this README and all role/module docs up to date** as the collection evolves.
- **Encourage contributors** to follow these conventions for all new roles, modules, and features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update documentation for any new features, roles, or modules. See individual role READMEs for detailed contribution guidelines.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.

## License

{{ license | default('AGPL-3.0') }}

## Author Information

{{ author | default('levonk') }}

*Document generated on: {{ "now" | strftime("%Y-%m-%d") }}*  
*Version: {{ collection_version | default('1.0.0') }}*

Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
