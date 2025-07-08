# Ansible Galaxy Collection Documentation Guide

> **Navigation**: [Back to Documentation Index](../README.md)

## Table of Contents

- [Ansible Galaxy Collection Documentation Guide](#ansible-galaxy-collection-documentation-guide)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Documentation Structure](#documentation-structure)
    - [Inventory Directory Structure](#inventory-directory-structure)
  - [Collection Documentation](#collection-documentation)
    - [Collection README.md](#collection-readmemd)
    - [Example Playbooks](#example-playbooks)
    - [Role Examples](#role-examples)
  - [Role Documentation](#role-documentation)
    - [Role README.md](#role-readmemd)
  - [Module Documentation](#module-documentation)
    - [Module Documentation](#module-documentation-1)
  - [Example Playbooks](#example-playbooks-1)
  - [Testing and Validation](#testing-and-validation)
    - [Test Structure](#test-structure)
    - [Testing Requirements](#testing-requirements)
  - [Best Practices](#best-practices)
    - [Documentation Guidelines](#documentation-guidelines)
  - [Templates](#templates)
  - [License and Compliance](#license-and-compliance)
    - [License Information](#license-information)
    - [Compliance Guidelines](#compliance-guidelines)


## Introduction

This guide provides standards and templates for documenting Ansible Galaxy collections. Good documentation is crucial for:

- User adoption and ease of use
- Maintenance and collaboration
- Quality assurance
- Community contributions

## Documentation Structure

A well-documented collection should include:

```yaml
collection/
├── docs/
│   ├── README.md              # Main collection documentation (use template: collection-detail-template.md)
│   ├── roles/                 # Role-specific documentation
│   │   └── role_name/
│   │       ├── README.md      # (use template: role-readme-template.md)
│   │       └── EXAMPLES.md    # (use template: role-example-template.md)
│   └── modules/               # Module documentation
│       └── module_name.md     # (use template: module-documentation-template.md)
├── examples/                  # Example playbooks and configurations
│   ├── site.yml              # (use template: site-template.yml)
│   └── inventory/            # (use template: inventory-template/)
│       ├── group_vars/       # Group-specific variables
│       ├── host_vars/        # Host-specific variables
│       └── hosts             # Inventory file
└── README.md                  # Basic collection overview (use template: collection-readme-template.md)
```


### Inventory Directory Structure

The `examples/inventory/` directory should contain:

- `hosts` - Main inventory file defining hosts and groups
- `group_vars/` - Directory for group-specific variables
  - `all/` - Variables for all hosts
  - `group_name/` - Variables specific to a group
- `host_vars/` - Directory for host-specific variables
  - `hostname/` - Variables specific to a host

This structure helps organize inventory data and makes it easier to manage complex deployments with multiple environments (dev, staging, production).


## Collection Documentation

### Collection README.md

Location: `docs/README.md`

Template: `templates/collection-detail-template.md`

Should include:

- Collection name and description
- Installation instructions
- Requirements and dependencies
- Quick start guide
- Links to detailed documentation
- License information
- Author and support information
- Badges (version, build status, license, etc.)
- Table of contents with anchor links
- Security and compliance information
- Testing and validation procedures


### Example Playbooks

Location: `examples/site.yml`

Template: `templates/site-template.yml`

Should include:

- Basic usage examples
- Common scenarios
- Integration with other modules/roles
- Best practices for using the collection


### Role Examples

Location: `docs/roles/role_name/EXAMPLES.md`

Template: `templates/role-example-template.md`

Should include:

- Detailed role usage examples
- Common variable configurations
- Integration with other roles
- Advanced use cases
- Troubleshooting tips


## Role Documentation

### Role README.md
Location: `docs/roles/role_name/README.md`

Should include:
- Role name and purpose
- Supported platforms
- Role variables (with defaults and descriptions)
- Dependencies
- Example playbook
- License

## Module Documentation

### Module Documentation
Location: `docs/modules/module_name.md`

Should include:
- Synopsis
- Requirements
- Parameters
- Return values
- Examples
- Status and support

## Example Playbooks

Location: `examples/`

Include practical examples that demonstrate:
- Basic usage
- Common scenarios
- Integration with other modules/roles
- Best practices

## Testing and Validation

### Test Structure

```yaml
tests/
  integration/       # Integration tests
  unit/             # Unit tests
  molecule/         # Molecule test scenarios
    default/        # Default test scenario
      converge.yml
      molecule.yml
      verify.yml
```

### Testing Requirements

- All features must have corresponding Gherkin feature files
- Tests must cover functional and non-functional requirements
- Include security testing and edge cases
- Maintain >80% test coverage
- Run tests in CI/CD pipeline


## Best Practices

### Documentation Guidelines

1. **Be Consistent**
   - Follow the templates provided
   - Use consistent formatting and style
   - Maintain a consistent voice and tone

2. **Be Clear and Concise**
   - Use simple, direct language
   - Avoid jargon when possible
   - Include examples for complex concepts

3. **Be Complete**
   - Document all parameters and options
   - Include examples for common use cases
   - Document any known issues or limitations
   - Include security considerations
   - Document compliance requirements

4. **Be Maintainable**
   - Keep documentation up to date with code changes
   - Use includes and references to avoid duplication
   - Structure content for easy navigation
   - Include version compatibility information

5. **Be Accessible**
   - Use proper heading structure
   - Include alt text for images
   - Ensure good color contrast
   - Write clear link text
   - Follow WCAG guidelines

## Templates

Available templates in the `templates/` directory:

1. `collection-detail-template.md` - For the main collection documentation (docs/README.md)
2. `collection-readme-template.md` - For the root README.md
3. `collection-architecture-template.md` - For architecture documentation
4. `role-readme-template.md` - For role documentation
5. `role-example-template.md` - For role examples
6. `module-documentation-template.md` - For module documentation
7. `site-template.yml` - For example playbooks
8. `inventory-template/` - Directory structure for inventory examples

## License and Compliance

### License Information

All files must include the following license header:

```yaml
Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
```

### Compliance Guidelines

- Document all third-party dependencies and their licenses
- Include security considerations in all documentation
- Follow data protection regulations (GDPR, CCPA, etc.)
- Document any export control requirements
- Include accessibility compliance information


---
*Last updated: 2025-07-08*
