# language: en
@dev-js @prettier @cross-platform @bdd
Feature: Install Prettier
  As a developer
  I want Prettier to be installed globally via npm
  So that I can format JavaScript code consistently across platforms

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install Prettier on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_prettier: <enabled>
    Then Prettier is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: Prettier install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: Prettier install is idempotent
    Given Prettier is already installed
    When the dev-js role runs
    Then Prettier is not reinstalled
