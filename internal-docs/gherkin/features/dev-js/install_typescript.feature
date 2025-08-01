# language: en
@dev-js @typescript @cross-platform @bdd
Feature: Install TypeScript
  As a developer
  I want TypeScript to be installed globally via npm
  So that I can develop and compile typed JavaScript on any platform

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install TypeScript on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_typescript: <enabled>
    Then TypeScript is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: TypeScript install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: TypeScript install is idempotent
    Given TypeScript is already installed
    When the dev-js role runs
    Then TypeScript is not reinstalled
