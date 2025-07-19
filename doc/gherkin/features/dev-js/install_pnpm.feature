# language: en
@dev-js @pnpm @cross-platform @bdd
Feature: Install pnpm (Performant npm)
  As a developer
  I want pnpm to be installed globally and optionally managed by corepack
  So that I can use a fast and reliable package manager

  Background:
    Given the dev-js role is included in the playbook

  Scenario Outline: Install pnpm on supported OS
    Given the system is <os>
    When the dev-js role runs with dev_js_install_pnpm: <enabled>
    Then pnpm is <expected_state> on the system

    Examples:
      | os        | enabled | expected_state |
      | linux     | true    | installed      |
      | windows   | true    | installed      |
      | macos     | true    | installed      |
      | linux     | false   | not installed  |
      | windows   | false   | not installed  |
      | macos     | false   | not installed  |

  Scenario: pnpm install fails gracefully on unsupported OS
    Given the system is unsupported_os
    When the dev-js role runs
    Then an informative error is shown

  Scenario: pnpm install is idempotent
    Given pnpm is already installed
    When the dev-js role runs
    Then pnpm is not reinstalled

  Scenario: pnpm is installed via corepack when supported
    When Node.js version supports corepack
    Then pnpm is managed by corepack
