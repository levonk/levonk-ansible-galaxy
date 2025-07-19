# language: en
@dev-js @nodejs @cross-platform @bdd
Feature: Install Node.js and npm
  As a developer
  I want Node.js and npm to be installed and managed idempotently on all platforms
  So that JavaScript tooling works reliably everywhere

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install Node.js and npm on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_nodejs: <enabled>
    Then Node.js and npm are <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: Node.js install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: Node.js install is idempotent
    Given Node.js is already installed
    When the dev-js role runs
    Then Node.js is not reinstalled

  Scenario: Node.js install uses only trusted sources
    When the dev-js role runs
    Then only official package managers or sources are used
