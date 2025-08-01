# language: en
@dev-js @eslint @cross-platform @bdd
Feature: Install ESLint
  As a developer
  I want ESLint to be installed globally via npm
  So that I can lint JavaScript code consistently across platforms

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install ESLint on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_eslint: <enabled>
    Then ESLint is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: ESLint install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: ESLint install is idempotent
    Given ESLint is already installed
    When the dev-js role runs
    Then ESLint is not reinstalled
