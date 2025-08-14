# Shell Executor

This directory contains a custom Nx executor for running shell commands and scripts with environment variable support.

## Overview

The shell executor provides a flexible way to execute shell commands or scripts as part of the Nx build process. It supports:
- Running shell commands directly
- Executing script files with arguments
- Environment variable management
- Working directory configuration
- Command output handling

## Files

- `executor.json`: Executor configuration and metadata
- `impl.mjs`: ESM implementation of the executor
- `impl.cjs`: CommonJS wrapper for compatibility
- `schema.json`: JSON schema for executor options
- `package.json`: Package configuration and dependencies

## Usage

### Basic Command Execution

```json
// project.json
{
  "targets": {
    "example": {
      "executor": "@levonk-ansible-galaxy/shell:shell",
      "options": {
        "command": "echo Hello, World!"
      }
    }
  }
}
```

### Script Execution

```json
// project.json
{
  "targets": {
    "run-script": {
      "executor": "@levonk-ansible-galaxy/shell:shell",
      "options": {
        "script": "scripts/myscript.sh",
        "args": ["arg1", "arg2"],
        "cwd": "./src"
      }
    }
  }
}
```

### Environment Variables

```json
// project.json
{
  "targets": {
    "with-env": {
      "executor": "@levonk-ansible-galaxy/shell:shell",
      "options": {
        "command": "echo $GREETING",
        "env": {
          "GREETING": "Hello from Nx!"
        }
      }
    }
  }
}
```

## Options

| Option   | Type   | Required | Default | Description |
|----------|--------|----------|---------|-------------|
| command  | string | No       | -       | Shell command to execute |
| script   | string | No       | -       | Path to script file to execute |
| args     | array  | No       | []      | Arguments to pass to the script |
| cwd      | string | No       | .       | Working directory for the command |
| env      | object | No       | {}      | Environment variables to set |

## Error Handling

The executor will throw an error if:
- Neither `command` nor `script` is provided
- The specified script file doesn't exist
- The command or script returns a non-zero exit code

## Best Practices

1. Use `script` for complex commands that should be version controlled
2. Keep environment-specific configuration in workspace or project configuration
3. Use `cwd` to ensure commands run in the correct directory
4. Document any required environment variables in your project's documentation
