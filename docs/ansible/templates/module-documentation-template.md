# {{ module_name }} module

## Synopsis

{{ module_description }}

## Requirements

- Python {{ min_python_version | default('3.6+') }}
- Additional Python packages (if any)

## Parameters

| Parameter | Required | Default | Type | Choices | Description |
|-----------|----------|---------|------|----------|-------------|
| `name` | yes | | string | | Description of the parameter |
| `state` | no | `present` | string | `present`, `absent` | The desired state of the resource |

## Return Values

| Name | Description | Returned | Type |
|------|-------------|----------|------|
| `changed` | Whether the module made changes | always | boolean |
| `message` | Human-readable message | always | string |

## Examples

```yaml
# Basic usage
- name: Example task
  {{ module_fqcn }}:
    name: example
    state: present
  register: result
```

## Status

- **Stability**: {{ stability | default('preview') }}
- **Support**: {{ support | default('community') }}
- **Maintainer**: {{ maintainer | default('community') }}

## Notes

- Any additional notes or warnings
- Special considerations
- Known limitations

## License

{{ license | default('MIT') }}

## Author

{{ author | default('Your Name') }}

*Document generated on: {{ "now" | strftime("%Y-%m-%d") }}*  
*Version: {{ collection_version | default('1.0.0') }}*

Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
