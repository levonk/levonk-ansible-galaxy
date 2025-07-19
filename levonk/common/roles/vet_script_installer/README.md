# levonk.common.vet_script_installer

## Overview

**`vet_script_installer`** is a secure, modular Ansible role for safely installing and executing remote scripts. It enforces:
- **Checksum validation** (local or remote, with audit logging)
- **Vetting** using the [vet](https://github.com/vet-run/vet) security tool
- **Fail-fast behavior** if validation fails or is required
- **Emoji-rich, single-line audit logs** for every validation

This role is designed for use by other roles/collections to ensure robust, compliant, and auditable script execution in automation workflows.

---

## How to Use (from any role/collection)

### Minimal Secure Example
```yaml
- import_role:
    name: levonk.common.vet_script_installer
  vars:
    vet_script_url: "https://example.com/install.sh"
    vet_script_dest: "/tmp/install.sh"
```

### Strict Security Example (Recommended)
```yaml
- import_role:
    name: levonk.common.vet_script_installer
  vars:
    vet_script_url: "https://example.com/install.sh"
    vet_script_dest: "/tmp/install.sh"
    vet_script_checksum: "abcdef123456..."  # Strongly recommended
    vet_script_checksum_algo: "sha256"       # Optional, default is sha256
    vet_script_checksum_url: "https://example.com/install.sh.sha256"  # Optional
    vet_script_checksum_required: true        # Fail if not validated
    vet_script_log_checksum: true             # Audit log
    vet_script_args: "--flag1 --flag2"       # Optional

    # Vet binary checksum enforcement (optional, recommended for supply chain security)
    vet_bin_checksum: "1234abcd..."
    vet_bin_checksum_algo: "sha256"
    vet_bin_checksum_url: "https://github.com/vet-run/vet/releases/latest/download/vet-linux-amd64.sha256"
    vet_bin_checksum_required: true
    vet_bin_log_checksum: true
```

### What Happens
- Downloads the vet binary (if missing), validates it with checksum (local or remote).
- Downloads the script, validates it with checksum (local or remote).
- Vets the script using the `vet` tool.
- Executes the script **only if** all validations pass.
- Logs a single emoji summary line for each validation (see below).

---

## Integration Pattern for Other Roles/Collections
- **Always use this role as your abstraction for secure script execution.**
- **Do NOT duplicate checksum or vetting logic.**
- Supply only the script URL, destination, and (optionally) checksum variables.
- All audit, enforcement, and logging is handled for you.
- If the process changes (e.g., new vetting tool), only this role needs updating.

---

## Variables

### Script Validation
- `vet_script_url` (**required**): URL to the script to download and vet.
- `vet_script_dest` (**required**): Local path to save the script.
- `vet_script_checksum`: Expected checksum value (optional, recommended for strictness).
- `vet_script_checksum_algo`: Checksum algorithm (`sha256`, `sha512`, `sha1`, default: `sha256`).
- `vet_script_checksum_url`: URL to fetch checksum file (optional, will auto-discover if not set).
- `vet_script_checksum_required`: If true, fail if checksum is missing or does not match (default: false).
- `vet_script_log_checksum`: Log checksum computation and validation (default: true).
- `vet_script_args`: Arguments to pass to the script on execution (optional).

### Vet Binary Validation
- `vet_bin_checksum`: Expected checksum for vet binary (optional).
- `vet_bin_checksum_algo`: Algorithm for vet binary checksum (default: `sha256`).
- `vet_bin_checksum_url`: URL to vet binary checksum file (optional).
- `vet_bin_checksum_required`: If true, fail if vet binary checksum is missing or does not match (default: false).
- `vet_bin_log_checksum`: Log vet binary checksum computation and validation (default: true).

---

## Audit Logging & Emoji Summary
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
