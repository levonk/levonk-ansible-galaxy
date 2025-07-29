# JSON Tools

This directory contains utilities for working with JSON data.

## jqfmt

A JSON formatter that uses jq under the hood.

### Installation

The jqfmt tool is automatically installed by the `install_jqfmt.yml` playbook.

### Usage

```bash
# Format a JSON file
jqfmt input.json > output.json

# Format JSON from stdin
echo '{"key":"value"}' | jqfmt
```

### Requirements

- Python 3.6+
- jq (installed automatically by the playbook)

### Files

- `jqfmt/` - The jqfmt tool source code
- `install_jqfmt.yml` - Playbook to install jqfmt
- `test_jqfmt.yml` - Playbook to test jqfmt installation
