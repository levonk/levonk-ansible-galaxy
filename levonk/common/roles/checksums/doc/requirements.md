# Requirements for checksums role

- Ansible >= 2.10
- Supported OS: All major platforms (Linux, macOS, Windows)
- Python >= 3.6 on control node
- Supports sha256, sha512, and other major checksum algorithms
- Must log all validation results with emoji and audit details
- Must fail fast on checksum mismatch
- Must support remote and local checksum file sources
- BDD: Gherkin feature coverage for valid, invalid, missing, and unsupported algorithm cases
- Compliance: // TODO: Compliance (add regulatory/legal checks as needed)
