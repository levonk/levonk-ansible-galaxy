Feature: Vim Editor (AstroVim) Installation and Usability
  As a developer
  I want a modern Vim editor setup to be installed and usable on all supported platforms
  So that I can use an extensible text editor in my shell environment

  Background:
    Given a fresh system with the thick-shell role applied

  Scenario: Editor is installed on Debian/Ubuntu
    When I run `nvim --version` on Debian/Ubuntu
    Then the output should contain "NVIM"

  Scenario: Editor is installed on macOS
    When I run `nvim --version` on macOS
    Then the output should contain "NVIM"

  Scenario: Editor is installed on Windows
    When I run `nvim --version` on Windows
    Then the output should contain "NVIM"

  Scenario: Editor launches and exits cleanly
    When I run `nvim --headless +qall`
    Then the exit code should be 0

  Scenario: Editor configuration directory exists
    Then the directory ~/.config/nvim should exist
