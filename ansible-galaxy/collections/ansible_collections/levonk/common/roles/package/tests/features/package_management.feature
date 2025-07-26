Feature: Cross-platform secure package management

  # --- Linux scenario (TDD-first: should fail until implemented) ---
  Scenario: Install a package on Linux
    Given a supported Linux system
    When I request to install "curl" with state "latest"
    Then the package is installed and verified
    And the operation is cached for future runs
    And compliance TODOs are present in the codebase

  # --- Windows scenario (should fail until implemented) ---
  Scenario: Install a package on Windows (WinGet/Chocolatey fallback)
    Given a supported Windows 10+ system
    When I request to install "7zip"
    Then the package is installed using WinGet or Chocolatey
    And the operation is cached for future runs
    And compliance TODOs are present in the codebase

  # --- macOS scenario (should fail until implemented) ---
  Scenario: Install a package on macOS (Homebrew)
    Given a supported macOS system
    When I request to install "wget"
    Then the package is installed and verified
    And the operation is cached for future runs
    And compliance TODOs are present in the codebase

  # --- Security edge case ---
  Scenario: Fail install if checksum does not match
    Given a package installer with an invalid checksum
    When I request to install the package
    Then the installation fails with a security warning
    And compliance TODOs are present in the codebase

  # --- Compliance edge case ---
  Scenario: Warn on missing compliance TODO
    Given a package is installed from a third-party source
    When I review the codebase
    Then a "// TODO: Compliance" comment and test are present
