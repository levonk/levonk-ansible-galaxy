Feature: Checksums Role
  Ensures secure, auditable, and cross-platform checksum validation for files.

  Background:
    Given a file and its expected checksum
    And a supported algorithm (sha256, sha512, etc)

  Scenario: Valid checksum
    When the checksums role is run
    And the file checksum matches
    Then the task passes and logs success

  Scenario: Invalid checksum
    When the file checksum does not match
    Then the task fails
    And a clear error and audit log is emitted

  Scenario: Missing checksum file
    When the checksum file is missing
    Then the role fails with a descriptive error

  Scenario: Unsupported algorithm
    When an unsupported checksum algorithm is given
    Then the role fails and logs the error

  Scenario: Logging and audit
    When a checksum is validated
    Then the log includes emoji status and all relevant details
