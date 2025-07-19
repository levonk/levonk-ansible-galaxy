Feature: Cross-platform timezone and NTP configuration
  As a systems administrator
  I want the base_system role to set the correct timezone and configure NTP
  So that all hosts have accurate time and are compliant with security and audit requirements

  Background:
    Given a supported OS (Linux, macOS, Windows)
    And the base_system role is included in the playbook

  Scenario: Set timezone using variable
    Given the variable "timezone" is set to "America/Los_Angeles"
    When the role is applied
    Then the system timezone should be "America/Los_Angeles"
    And the change should be idempotent
    And the task should be logged

  Scenario: Configure custom NTP servers
    Given the variable "ntp_servers" is set to ["time.cloudflare.com", "time.google.com"]
    When the role is applied
    Then the NTP configuration file should contain both servers
    And the NTP service should be enabled and running
    And the configuration should be idempotent

  Scenario: Default NTP server fallback
    Given no "ntp_servers" variable is set
    When the role is applied
    Then the NTP configuration file should contain the default servers

  Scenario: Windows Time Service configuration
    Given the OS is Windows
    When the role is applied
    Then the Windows Time Service should be running
    And the NTP peers should be configured

  Scenario: Error handling for invalid timezone
    Given the variable "timezone" is set to "Invalid/Zone"
    When the role is applied
    Then the role should fail gracefully with a clear error message

  Scenario: Security and compliance
    When the role is applied
    Then only trusted NTP servers should be used
    And the configuration should not allow unauthenticated modification
