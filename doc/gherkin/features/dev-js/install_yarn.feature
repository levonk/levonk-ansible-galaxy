# language: en
@dev-js @yarn @cross-platform @bdd
Feature: Install Yarn package manager
  As a developer
  I want Yarn to be installed globally and optionally managed by corepack
  So that I can use a robust and fast package manager

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install Yarn on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_yarn: <enabled>
    Then Yarn is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: Yarn install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: Yarn install is idempotent
    Given Yarn is already installed
    When the dev-js role runs
    Then Yarn is not reinstalled

  Scenario: Yarn is installed via corepack when supported
    When Node.js version supports corepack
    Then Yarn is managed by corepack
