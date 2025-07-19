# Ansible Collection - levonk.base_system

## Windows Registry Backup Feature

This role automatically backs up all major Windows registry hives (HKLM, HKCU, HKU, HKCR, HKCC) to `C:\backup` before making any system changes. This ensures that system state can be restored if needed.

- **Feature defined in:** `docs/requirements/gherkin/windows-registry-backup.feature`
- **OS Support:** Tasks are split into `debian.yml`, `macos.yml`, and `windows.yml` for portability and maintainability.
- **Testing:** Molecule scenario `molecule/windows-registry-backup` verifies backup file creation and idempotency.
- **Security:** No scripts are executed without vetting. All tasks are idempotent and tagged.

See the Gherkin feature file and Molecule tests for full details and expected behavior.
