# language: en
@dev-js @create-react-app @cross-platform @bdd
Feature: Install Create React App
  As a developer
  I want Create React App to be installed globally via npm
  So that I can scaffold React projects easily across platforms

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install Create React App on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_create_react_app: <enabled>
    Then Create React App is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: Create React App install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: Create React App install is idempotent
    Given Create React App is already installed
    When the dev-js role runs
    Then Create React App is not reinstalled
