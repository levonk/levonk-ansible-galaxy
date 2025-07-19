# Requirements for vet_script_installer

- Ansible >= 2.10
- Supported OS: Debian/Ubuntu, RedHat/CentOS, Fedora, macOS, Windows
- Internet access for downloading vet, shellcheck, bat
- Python >= 3.6 on control node
- Role dependencies: levonk.common.checksums
- Security: All scripts and binaries must have published checksums (sha256 recommended)
- Audit logging must be enabled for compliance
- CI: Molecule and Testinfra for automated testing
- BDD: Gherkin feature coverage for all critical flows
- Compliance: See // TODO: Compliance for any regulatory or legal requirements
