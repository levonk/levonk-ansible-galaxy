# Ansible Role: checksums

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/checksums)

Reusable, cross-platform checksum validation for file downloads in Ansible. Supports local and remote checksum files, multiple hash types, and robust logging.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/checksums/tasks):

| Feature/Task                | Description                                      | Required Variable(s)                      | Source |
|-----------------------------|--------------------------------------------------|-------------------------------------------|--------|
| Local checksum file detect  | Finds local checksum files for a download target | `checksums_dest`                          | [tasks/main.yml](tasks/main.yml) |
| Remote checksum file fetch  | Downloads checksum file from remote if needed    | `checksums_download_url`                  | [tasks/main.yml](tasks/main.yml) |
| Checksum validation         | Validates downloaded file against checksum       | `checksums_checksum`, `checksums_dest`    | [tasks/main.yml](tasks/main.yml) |
| Logging & summary           | Logs pass/fail with emoji and details            | `checksums_log_checksum`                  | [tasks/main.yml](tasks/main.yml) |
| Download file if missing    | Downloads the target file if not present         | `checksums_download_url`, `checksums_dest`| [tasks/main.yml](tasks/main.yml) |
| Ensure checksum tool        | Installs coreutils for checksum validation       | *(auto-detect)*                           | [tasks/main.yml](tasks/main.yml) |

---

## Detailed Feature Documentation

### Local Checksum File Detect
- **Description:** Finds local checksum files (sha256, sha512, sha1) next to the target file.
- **Tags:** `checksums`, `local`, `validation`
- **Idempotency:** Only sets fact if file exists.
- **Security:** No script execution.
- **Usage:** Set `checksums_dest` to the target file path.

### Remote Checksum File Fetch
- **Description:** Tries multiple candidate URLs to fetch a checksum file if not found locally.
- **Tags:** `checksums`, `remote`, `validation`
- **Idempotency:** Only downloads if needed.
- **Security:** Uses HTTPS URLs.
- **Usage:** Set `checksums_download_url` to the base file URL.

### Checksum Validation
- **Description:** Validates the downloaded file against checksum from file or provided value.
- **Tags:** `checksums`, `validation`, `hash`
- **Idempotency:** Safe to run repeatedly.
- **Security:** Only uses official checksum tools.
- **Usage:** Provide `checksums_checksum` (optional) or rely on detected checksum file.

### Logging & Summary
- **Description:** Logs pass/fail/warning with emoji, file, hash, and notes.
- **Tags:** `checksums`, `logging`, `debug`
- **Usage:** Set `checksums_log_checksum: true` (default).

### Download File if Missing
- **Description:** Downloads the target file if not already present.
- **Tags:** `checksums`, `download`
- **Usage:** Set `checksums_download_url` and `checksums_dest`.

### Ensure Checksum Tool
- **Description:** Installs coreutils (Debian/RedHat) for checksum validation.
- **Tags:** `checksums`, `coreutils`, `deps`
- **Usage:** No user action needed.

---

## Variables

### Variable Table Legend
- **required**: Must be set for the role or feature to function.
- **recommended**: Strongly encouraged for best results or security, but not strictly required.
- **opt-in**: Feature is disabled by default; set this variable to enable it.
- **opt-out**: Feature is enabled by default; set this variable to disable or override it.

### Variable Reference

| Variable                | Default | Sample Value                  | Type    | Activation | Purpose                                     | Used In        |
|-------------------------|---------|-------------------------------|---------|------------|---------------------------------------------|----------------|
| `checksums_dest`        |         | `/tmp/myfile.tar.gz`          | string  | required   | Path to the file to validate/download       | all            |
| `checksums_download_url`|         | `https://example.com/myfile`  | string  | required   | URL to download the file/checksum           | download, fetch|
| `checksums_checksum`    |         | `abcdef1234...`               | string  | opt-in     | Explicit checksum value to validate against | validation     |
| `checksums_checksum_url`|         | `https://example.com/myfile.sha256` | string | opt-in | Explicit URL for checksum file              | fetch          |
| `checksums_log_checksum`| true    | false                         | bool    | opt-out    | Log summary/debug info                      | logging        |
| `checksums_checksum_required` | false | true                        | bool    | opt-in     | Fail if checksum is missing or mismatched   | validation     |
| `checksums_checksum_algo`| sha256 | sha512                        | string  | opt-in     | Hash algorithm to use                       | validation     |

---

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: levonk.common.checksums
      vars:
        checksums_dest: /tmp/myfile.tar.gz
        checksums_download_url: https://example.com/myfile.tar.gz
        checksums_checksum_url: https://example.com/myfile.tar.gz.sha256
        checksums_log_checksum: true
```

---

## Best Practices for Role Documentation
- **Document every variable** in a table with: name, default, sample, type, activation, purpose, and source link.
- **Use explicit enums** for variable activation/requirement status.
- **Link to the source** of each feature/task for transparency.
- **Provide usage examples** for all major features and variable combinations.
- **Document tags and advanced usage patterns** for selective feature activation.
- **Include explicit notes on idempotency and security** for each feature.
- **Keep README.md up to date** as the role evolves.
- **Encourage contributors** to follow this template for all new features.

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.


