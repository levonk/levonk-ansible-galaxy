# Open WebUI Role

This Ansible role installs and configures Open WebUI, a user-friendly web interface for interacting with Lite LLM and other language model backends.

## Features

- Easy installation and configuration of Open WebUI
- Integration with Lite LLM backend
- Systemd service management
- Virtual environment isolation
- Secure configuration with environment variables
- User authentication and access control
- File upload support
- Logging and monitoring

## Requirements

- Ansible 2.9 or higher
- Python 3.7 or higher
- Systemd (Linux)
- Git
- Root or sudo access (for systemd service management)

## Role Variables

### Main Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `open_webui_install_dir` | `~/open-webui` | Installation directory |
| `open_webui_venv` | `~/.local/share/open-webui/venv` | Python virtual environment path |
| `open_webui_data_dir` | `~/.local/share/open-webui` | Data directory |
| `open_webui_config_dir` | `~/.config/open-webui` | Configuration directory |
| `open_webui_config_file` | `{{ open_webui_config_dir }}/config.yaml` | Configuration file path |
| `open_webui_log_file` | `{{ open_webui_data_dir }}/open-webui.log` | Log file path |
| `open_webui_host` | `0.0.0.0` | Host to bind the server to |
| `open_webui_port` | `3000` | Port to run the server on |
| `open_webui_litellm_url` | `http://localhost:4000` | Lite LLM backend URL |
| `open_webui_auth_enabled` | `true` | Enable authentication |
| `open_webui_admin_email` | `admin@example.com` | Admin email |
| `open_webui_admin_password` | Auto-generated | Admin password (auto-generated if not set) |
| `open_webui_secret_key` | Auto-generated | Secret key for session encryption |
| `open_webui_max_upload_size` | `100` | Maximum file upload size (MB) |
| `open_webui_log_level` | `info` | Logging level |
| `open_webui_user` | `{{ ansible_user }}` | User to run the service as |
| `open_webui_group` | `{{ ansible_user }}` | Group to run the service as |

## Dependencies

- Python 3.7+
- pip
- Git
- systemd (for service management)

## Example Playbook

```yaml
- hosts: webui_servers
  become: true
  roles:
    - role: levonk.server_llmchat.open_webui
      vars:
        open_webui_host: "0.0.0.0"
        open_webui_port: 3000
        open_webui_litellm_url: "http://llm-server:4000"
        open_webui_admin_email: "admin@yourdomain.com"
        open_webui_admin_password: "your-secure-password"
```

## Usage

1. **Basic Installation**:
   ```bash
   ansible-playbook your-playbook.yml --tags open-webui
   ```

2. **Custom Configuration**:
   ```yaml
   - hosts: your_servers
     roles:
       - role: levonk.server_llmchat.open_webui
         vars:
           open_webui_port: 8080
           open_webui_host: "127.0.0.1"
           open_webui_auth_enabled: true
   ```

3. **Access the WebUI**:
   Open a web browser and navigate to `http://<server-ip>:3000`

## License

MIT

## Author Information

Your Name (@yourusername)
