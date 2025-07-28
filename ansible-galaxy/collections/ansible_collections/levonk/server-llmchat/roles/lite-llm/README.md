# Lite LLM Role

This Ansible role installs and configures Lite LLM, a lightweight language model server that provides a simple API for interacting with various language models.

## Features

- Easy installation and configuration of Lite LLM
- Support for multiple language models
- Systemd service management
- Virtual environment isolation
- Secure configuration with environment variables
- Logging and monitoring support

## Requirements

- Ansible 2.9 or higher
- Python 3.7 or higher
- Systemd (Linux)
- Root or sudo access (for systemd service management)

## Role Variables

### Main Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `lite_llm_venv_path` | `~/.local/share/litellm/venv` | Path to the Python virtual environment |
| `lite_llm_config_dir` | `~/.litellm` | Directory for Lite LLM configuration |
| `lite_llm_config_file` | `{{ lite_llm_config_dir }}/config.yaml` | Path to the configuration file |
| `lite_llm_host` | `0.0.0.0` | Host to bind the Lite LLM server to |
| `lite_llm_port` | `4000` | Port to run the Lite LLM server on |
| `lite_llm_workers` | `2` | Number of worker processes |
| `lite_llm_model` | `gpt-3.5-turbo` | Default language model to use |
| `lite_llm_api_key` | `""` | API key for the language model (if required) |
| `lite_llm_service_user` | `{{ ansible_user }}` | User to run the Lite LLM service as |
| `lite_llm_service_group` | `{{ ansible_user }}` | Group to run the Lite LLM service as |

## Dependencies

- Python 3.7+
- pip
- systemd (for service management)

## Example Playbook

```yaml
- hosts: llm_servers
  become: true
  roles:
    - role: levonk.server_llmchat.lite_llm
      vars:
        lite_llm_model: "gpt-4"
        lite_llm_api_key: "your-api-key-here"
        lite_llm_port: 8080
```

## License

MIT

## Author Information

Your Name (@yourusername)
