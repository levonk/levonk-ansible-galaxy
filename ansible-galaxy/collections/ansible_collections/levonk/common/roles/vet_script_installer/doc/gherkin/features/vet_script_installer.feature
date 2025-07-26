Feature: Vet Script Installer Role
  This feature ensures secure, cross-platform vetting of scripts with dependency and checksum enforcement.

  Background:
    Given a supported OS (Debian, RedHat, Fedora, macOS, Windows)
    And a script and vet binary with published checksums

  Scenario: Successful vetting and execution
    When the vet_script_installer role is run
    Then shellcheck and bat are installed for the platform
    And the vet binary is downloaded and validated by checksum
    And the script is downloaded and validated by checksum
    And the script is vetted by vet
    And audit logs are generated
    And the script is executed

  Scenario: Checksum mismatch for vet binary
    When the vet binary checksum does not match
    Then the role fails before running vet or script
    And a clear error and audit log is emitted

  Scenario: Dependency installation fails
    When a dependency (shellcheck or bat) cannot be installed
    Then the role fails and logs the error

  Scenario: Vetting fails
    When vet finds issues in the script
    Then the script is not executed
    And the failure is logged

  Scenario: Windows support
    Given the OS is Windows
    Then dependencies are installed with Chocolatey
    And all checksum and vetting logic still applies
