# language: en
@dev-js @vite @cross-platform @bdd
Feature: Install Vite
  As a developer
  I want Vite to be installed globally via npm
  So that I can scaffold and serve modern JavaScript projects across platforms

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install Vite on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_vite: <enabled>
    Then Vite is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: Vite install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: Vite install is idempotent
    Given Vite is already installed
    When the dev-js role runs
    Then Vite is not reinstalled
