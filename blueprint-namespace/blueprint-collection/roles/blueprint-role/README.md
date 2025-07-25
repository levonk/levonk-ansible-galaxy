# Ansible Role: blueprint-namespace.blueprint-collection.blueprint-role

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/blueprint-namespace/blueprint-collection/roles/blueprint-role)

This role is a template for best-practices Ansible role documentation, variable usage, and feature tables.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks):

| Feature/Task | Description | Required Variable(s) | Source |
|--------------|-------------|----------------------|--------|
| Example Feature 1 | Describe what this feature does | [`example_required_var`](#example_required_var) | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/main.yml) |
| Example Feature 2 | Describe another feature | [`example_opt_in_var`](#example_opt_in_var) | [tasks/feature2.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/feature2.yml) |

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks):

| Feature/Task | Description | Required Variable(s) | Source |
|--------------|-------------|----------------------|--------|
| Example Feature 1 | Describe what this feature does | [`example_required_var`](#example_required_var) | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/main.yml) |
| Example Feature 2 | Describe another feature | [`example_opt_in_var`](#example_opt_in_var) | [tasks/feature2.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/feature2.yml) |

---

## Detailed Feature Documentation

<!--
For each feature, copy and fill in the following template. Remove this comment block in real roles.
-->

### Example Feature 1

**Description:**
> Briefly describe what this feature does and why it exists.

- **Feature definition:** [docs/requirements/gherkin/example_feature1.feature](docs/requirements/gherkin/example_feature1.feature)
- **Supported Platforms:** Windows, MacOS, Debian, ...
- **Tags:** `example`, `feature1`, `blueprint-role`
- **Testing:** Molecule scenario verifies correct behavior and idempotency.
- **Idempotency:** Safe to run repeatedly; only applies changes if not already present.
- **Security:** Uses only official or trusted sources.
- **Usage:**
  - Activate by setting `example_required_var` in your playbook or inventory.
  - Example:
    ```yaml
    - role: blueprint-namespace.blueprint-collection.blueprint-role
      vars:
        example_required_var: foo
    ```

### Example Feature 2

**Description:**
> Another feature description.

- **Feature definition:** [docs/requirements/gherkin/example_feature2.feature](docs/requirements/gherkin/example_feature2.feature)
- **Supported Platforms:** Windows, MacOS, Debian, ...
- **Tags:** `example`, `feature2`, `blueprint-role`
- **Testing:** Molecule scenario covers feature activation and edge cases.
- **Idempotency:** Task is safe to run repeatedly.
- **Security:** All downloads are checksum-verified.
- **Usage:**
  - Activate by setting `example_opt_in_var: true`.
  - Example:
    ```yaml
    - role: blueprint-namespace.blueprint-collection.blueprint-role
      vars:
        example_opt_in_var: true
    ```

---

## Usage

### Variables

#### Variable Table Legend

- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

---

#### Variable Reference

| Variable | Default | Sample Value | Type | Activation | Purpose | Used In |
|----------|---------|--------------|------|------------|---------|---------|
| <a name="example_required_var"></a>`example_required_var` | *(unset)* | `foo` | string | required | Must be set for the role to work | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/main.yml) |
| <a name="example_recommended_var"></a>`example_recommended_var` | `bar` | `custom_bar` | string | recommended | Improves security or usability | [tasks/main.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/main.yml) |
| <a name="example_opt_in_var"></a>`example_opt_in_var` | `false` | `true` | bool | opt-in | Enables optional feature | [tasks/feature2.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/feature2.yml) |
| <a name="example_opt_out_var"></a>`example_opt_out_var` | `true` | `false` | bool | opt-out | Disables default-enabled feature | [tasks/feature3.yml](https://github.com/levonk/levonk-ansible-galaxy/blob/main/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/feature3.yml) |

---

### Requirements

- Ansible {{ min_ansible_version | default('2.9+') }}
- Python {{ min_python_version | default('3.6+') }}
- ...

---

### Dependencies

---

### Example Playbooks

```yaml
- hosts: all
  roles:
    - role: blueprint-namespace.blueprint-collection.blueprint-role
      vars:
        example_required_var: foo
        example_recommended_var: custom_bar
        example_opt_in_var: true
        example_opt_out_var: false
```

---

## Best Practices for Role Documentation

- **Always document every variable** in a table with: name, default, sample, type, activation (required/recommended/opt-in/opt-out), purpose, and source link.
- **Use explicit enums** for variable activation/requirement status (`required`, `recommended`, `opt-in`, `opt-out`).
- **Link to the source** of each feature/task and variable usage for transparency and maintainability.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Reference external specs or requirements** where relevant.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new roles and features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.