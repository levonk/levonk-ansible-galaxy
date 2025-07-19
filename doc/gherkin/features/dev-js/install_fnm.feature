# language: en
@dev-js @fnm @cross-platform @bdd
Feature: Install Fast Node Manager (fnm)
  As a developer
  I want fnm to be installed and integrated with the shell
  So that I can easily manage Node.js versions across platforms

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install fnm on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_fnm: <enabled>
    Then fnm is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: fnm install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: fnm shell integration is present
    When fnm is installed
    Then shell init scripts are updated for bash, zsh, and fish

  Scenario: fnm install is idempotent
    Given fnm is already installed
    When the dev-js role runs
    Then fnm is not reinstalled
