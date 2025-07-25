# Ansible Role: levonk.common.vet_script_installer

[Source on GitHub](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/vet_script_installer)

A secure, modular Ansible role for safely downloading, vetting, and executing remote scripts. Enforces checksum validation, vetting with the [vet](https://github.com/vet-run/vet) security tool, and fail-fast behavior. Designed for robust, compliant, and auditable script execution in automation workflows.

---

## Features & Tasks

Below is a list of all major features and tasks performed by this role, with links to the source task files in the [levonk-ansible-galaxy GitHub repo](https://github.com/levonk/levonk-ansible-galaxy/tree/main/levonk/common/roles/vet_script_installer/tasks):

| Feature/Task                  | Description                                                  | Required Variable(s)                | Source |
|-------------------------------|--------------------------------------------------------------|-------------------------------------|--------|
| Download vet binary           | Fetches vet security tool for script vetting                 | *(none)*                            | [tasks/main.yml](tasks/main.yml) |
| Validate vet binary checksum  | Validates vet binary using checksums role                    | [`vet_bin_checksum`](#vet_bin_checksum) | [tasks/main.yml](tasks/main.yml) |
| Install vet dependencies      | Ensures shellcheck and bat are present                       | *(none)*                            | [tasks/vet-dependencies.yml](tasks/vet-dependencies.yml) |
| Download target script        | Downloads the script to vet and execute                      | [`vet_script_url`](#vet_script_url), [`vet_script_dest`](#vet_script_dest) | [tasks/main.yml](tasks/main.yml) |
| Validate script checksum      | Validates script checksum (local or remote)                  | [`vet_script_checksum`](#vet_script_checksum) | [tasks/main.yml](tasks/main.yml) |
| Vet script                    | Runs vet tool for non-interactive vetting                    | *(none)*                            | [tasks/main.yml](tasks/main.yml) |
| Execute script (if vetted)    | Executes script only if all validations pass                 | *(none)*                            | [tasks/main.yml](tasks/main.yml) |

---

### Audit Logging & Emoji Summary
Each checksum validation logs a single summary line:

- `✅` Pass: Checksum matched, script/binary is safe
- `❌` Fail: Checksum required but missing or mismatched
- `⚠️` Warning: Checksum not validated (not enforced)

**Example log:**
```
✅ Checksum validation: PASSED | File: /tmp/install.sh | Hash: abcdef... | HashFile: /tmp/install.sh.sha256 | Stated: abcdef... | HashFileSize: 74 | Line: abcdef...  install.sh | Notes:
```

All details (file, hash, source, size, notes) are included for full auditability.

---

## Detailed Feature Documentation

### Download vet binary
- **Description:** Downloads the vet binary if missing for secure script vetting.
- **Tags:** `vet`, `security`, `binary`
- **Idempotency:** Only downloads if not present.
- **Security:** Source URL is pinned to official GitHub releases.

### Validate vet binary checksum
- **Description:** Validates the vet binary using the checksums role and user-supplied or remote checksum.
- **Tags:** `vet`, `checksum`, `security`
- **Idempotency:** Only validates if checksum/checksum_url is set.
- **Security:** Prevents tampered vet binary execution.

### Install vet dependencies
- **Description:** Ensures shellcheck and bat are installed for full vetting capability.
- **Tags:** `vet`, `dependencies`, `shellcheck`, `bat`
- **Idempotency:** Installs only if missing.
- **Security:** Uses official package managers.

### Download target script
- **Description:** Downloads the script to be vetted and executed.
- **Tags:** `script`, `download`, `security`
- **Idempotency:** Only downloads if not present or changed.
- **Security:** Source URL is user-controlled.

### Validate script checksum
- **Description:** Validates the downloaded script using checksum (local value or remote URL).
- **Tags:** `script`, `checksum`, `security`
- **Idempotency:** Only validates if checksum/checksum_url is set.
- **Security:** Prevents execution of tampered scripts.

### Vet script
- **Description:** Runs the vet tool in non-interactive mode to analyze the script for security issues.
- **Tags:** `vet`, `security`, `analysis`
- **Idempotency:** Always safe to run.
- **Security:** Blocks execution if vet fails.

### Execute script (if vetted)
- **Description:** Executes the script only if all validations (checksum, vet) pass.
- **Tags:** `script`, `execution`, `security`
- **Idempotency:** Only executes if previous steps succeed.
- **Security:** Fails fast on validation errors.

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
| <a name="vet_script_url"></a>`vet_script_url` | *(unset)* | `https://example.com/install.sh` | string | required | URL to the script to download and vet | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_script_dest"></a>`vet_script_dest` | *(unset)* | `/tmp/install.sh` | string | required | Local path to save the script | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_script_checksum"></a>`vet_script_checksum` | *(unset)* | SHA256 hash | string | recommended | Validate script checksum | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_script_checksum_algo"></a>`vet_script_checksum_algo` | `sha256` | `sha512` | string | opt-out | Checksum algorithm for script | [vars/main.yml](vars/main.yml) |
| <a name="vet_script_checksum_url"></a>`vet_script_checksum_url` | *(unset)* | URL | string | opt-in | URL to fetch checksum file | [vars/main.yml](vars/main.yml) |
| <a name="vet_script_checksum_required"></a>`vet_script_checksum_required` | `false` | `true` | bool | opt-in | Fail if checksum is missing or does not match | [vars/main.yml](vars/main.yml) |
| <a name="vet_script_log_checksum"></a>`vet_script_log_checksum` | `true` | `false` | bool | opt-out | Log checksum computation and validation | [vars/main.yml](vars/main.yml) |
| <a name="vet_script_args"></a>`vet_script_args` | *(unset)* | `--flag1 --flag2` | string | opt-in | Arguments to pass to the script on execution | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_bin_checksum"></a>`vet_bin_checksum` | *(unset)* | SHA256 hash | string | recommended | Validate vet binary checksum | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_bin_checksum_algo"></a>`vet_bin_checksum_algo` | `sha256` | `sha512` | string | opt-out | Algorithm for vet binary checksum | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_bin_checksum_url"></a>`vet_bin_checksum_url` | *(unset)* | URL | string | opt-in | URL to fetch vet binary checksum | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_bin_checksum_required"></a>`vet_bin_checksum_required` | `false` | `true` | bool | opt-in | Fail if vet binary checksum is missing or does not match | [tasks/main.yml](tasks/main.yml) |
| <a name="vet_bin_log_checksum"></a>`vet_bin_log_checksum` | `true` | `false` | bool | opt-out | Log vet binary checksum computation and validation | [tasks/main.yml](tasks/main.yml) |

---

### Requirements

- Ansible 2.9+
- Python 3.6+
- Supported platforms: Linux, macOS, Windows (for script execution and vetting)

---

### Dependencies

- levonk.common.checksums
- levonk.common.package

---

### Example Playbooks

```yaml
- hosts: all
  roles:
    - role: levonk.common.vet_script_installer
      vars:
        vet_script_url: "https://example.com/install.sh"
        vet_script_dest: "/tmp/install.sh"
        vet_script_checksum: "abcdef123456..."
        vet_script_checksum_algo: "sha256"
        vet_script_checksum_required: true
        vet_script_log_checksum: true
        vet_script_args: "--flag1 --flag2"
        vet_bin_checksum: "1234abcd..."
        vet_bin_checksum_algo: "sha256"
        vet_bin_checksum_required: true
        vet_bin_log_checksum: true
```

---

## Contributing

Contributions should follow the documentation and variable table conventions shown above. Please update the README.md with any new features or variables.

---

## License

Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.



## Implementation Details
- Uses the `levonk.common.checksums` role for all checksum validation and logging.
- Ensures vet dependencies (`shellcheck`, `bat`) are installed on all major platforms before vetting (see next section).
- Supports local and remote checksum files (auto-discovers `.sha256`, `.sha512`, etc.).
- Only executes scripts that pass both checksum and vetting.
- All error handling, logging, and enforcement is centralized and DRY.

---

## Platform Dependencies: `shellcheck` and `bat`

For maximum security, the vetting process requires both `shellcheck` (for static shell analysis) and `bat` (for enhanced output display). This role **automatically installs these tools** before vetting, using the appropriate package manager for your OS:

- **Debian/Ubuntu:** Installs via `apt` (with `become: yes`)
- **RedHat/CentOS:** Installs via `yum` (with `become: yes`)
- **Fedora:** Installs via `dnf` (with `become: yes`)
- **macOS:** Installs via `homebrew` (requires `community.general` collection)
- **Windows:** Installs via `chocolatey` (requires `win_chocolatey` module)

All tasks are **idempotent** (safe to re-run), tagged with `vet, dependencies`, and only run on the matching OS. This ensures `vet` always has its required dependencies for full script analysis and output, maximizing security and auditability.

---

## Security & Compliance
- No untrusted code is executed unless it passes all validations.
- All actions are logged for compliance and audit.
- Can be used as a drop-in for any script installer in automation workflows.

---

## License
Copyright Brillarc, LLC. See LICENSE for details.
