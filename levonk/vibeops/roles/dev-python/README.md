# dev-python Role

This role sets up a Python development environment for users or CI systems. It supports:
- Python (pyenv, system, or Anaconda) install
- Virtualenv and pip configuration
- Common dev tools (black, flake8, pytest, etc.)

## Variables
- `python_version`: Python version to install
- `dev_python_tools`: List of tools to install

## Compliance
- Follows secure install practices
- Supports reproducible builds

## Testing
- Molecule scenario included for install and environment checks
