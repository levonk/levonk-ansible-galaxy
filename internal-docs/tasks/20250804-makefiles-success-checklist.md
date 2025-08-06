# Makefile Standardization Checklist

This is a companion checklist to the detail requirements in `20250804-makefiles-success.md` found in the same directory as this checklist.

## Core Directories
- [x] `Makefile` - Standardized with enhanced help, error handling, and common targets
- [x] `ansible-galaxy/Makefile` - Standardized with enhanced help, error handling, and common targets
- [x] `ansible-galaxy/Makefile.targets` - Standardized shared targets for collections
- [x] `ansible-galaxy/common.mk` - Standardized shared variables and settings
- [x] `ansible-galaxy/collections/Makefile` - Standardized with collection management targets, error handling, and status reporting
- [x] `ansible-galaxy/collections/ansible_collections/Makefile` - Standardized with namespace management, collection operations, and status reporting
- [x] `ansible-galaxy/collections/ansible_collections/levonk/Makefile` - Standardized with namespace management, collection operations, and status reporting

## Blueprint Templates (copier templates, not to run directly usually)
### Collection Structure
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/Makefile` - Enhanced with standardized targets including archive, format, docs, version, and status with improved error handling
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/Makefile` - Standardized with build, test, lint, format, clean, version, and status targets
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/Makefile` - Manages all roles with testing, linting, and formatting
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/plugins/Makefile` - Handles all plugins with testing and validation
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/plugins/modules/Makefile` - Manages custom Ansible modules with testing and validation
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/plugins/module_utils/Makefile` - Manages shared Python utilities for modules
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/playbooks/Makefile` - Manages playbook validation, testing, and execution
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/tests/Makefile` - Handles both unit and integration tests
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/docs/Makefile` - Manages documentation building and testing

### Role Template
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/Makefile` - Standardized with Molecule testing, linting, and documentation
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/tasks/Makefile` - Manages task files with linting and formatting
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/handlers/Makefile` - Manages handler files with linting and formatting
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/defaults/Makefile` - Manages default variables with linting and formatting
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/vars/Makefile` - Manages variable files with linting and formatting
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/meta/Makefile` - Manages role metadata with linting and validation
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/tests/Makefile` - Manages role tests with playbook execution
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/roles/blueprint-role/molecule/default/Makefile` - Standardized Molecule test environment management

### Module Template
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/plugins/modules/blueprint-module.py` - Template for new Ansible modules
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection/plugins/modules/Makefile.template` - Template for module Makefiles with testing and linting
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection-module/plugins/modules/Makefile` - Standardized Makefile for module development with testing and linting
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection-module/plugins/module_utils/Makefile` - Standardized Makefile for module utilities with testing and type checking
- [x] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/blueprint-collection-module/tests/Makefile` - Comprehensive test runner with support for unit and integration tests

## Implementation Priorities
1. Core directories and blueprint templates
2. Collection-level Makefiles
3. Role-level Makefiles
4. Test and molecule directories
5. Plugin and other support directories

## Verification
- [ ] All Makefiles exist in required directories
- [ ] All Makefiles follow standard structure
- [ ] All Makefiles pass linting
- [ ] All Makefiles have proper documentation
- [ ] All Makefile targets work as expected
- [ ] All test directories have corresponding Makefiles
- [ ] All molecule test directories have corresponding Makefiles


## Collections Level

### levonk.base_system
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/plugins/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/playbooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/tests/Makefile`

#### base_system Roles
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/base_system/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/reboot_manager/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/syscheck/Makefile`

### levonk.common
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/plugins/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/playbooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/tests/Makefile`

#### common Roles
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/ansible/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/ansible_builder/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/package/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/package_downloader/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/pip/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/reboot/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/reboot_management/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/syscheck/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/upgrade/Makefile`

### levonk.dev
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/plugins/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/playbooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/tests/Makefile`

#### dev Roles
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/dev_environment/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/dev_python/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/dev_rust/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/git/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/git_hooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/git_lfs/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/make/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/ssh/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/syscheck/Makefile`

### levonk.gamer
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/plugins/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/playbooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/tests/Makefile`

#### gamer Roles
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/gaming_environment/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/gaming_launchers/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/steam/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/syscheck/Makefile`

### levonk.hardened
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/plugins/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/playbooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/tests/Makefile`

### levonk.server_llmchat
- [x] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/Makefile` - Collection build and test automation
- [x] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/Makefile` - Role management with testing and linting
- [x] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/plugins/Makefile` - Plugin management and testing
- [x] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/playbooks/Makefile` - Playbook validation and testing
- [x] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/tests/Makefile` - Test suite management

#### server_llmchat Roles
- [x] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/open-webui/Makefile` - Open WebUI role with Molecule testing
- [x] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/syscheck/Makefile` - System check role with comprehensive testing

### levonk.user_setup
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/plugins/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/playbooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/tests/Makefile`

#### user_setup Roles
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/chezmoi/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/local_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/remote_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/service_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/thick_shell/Makefile`

### levonk.vibeops
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/plugins/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/playbooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/tests/Makefile`

#### vibeops Roles
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/3d-printing/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/browsers/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/comms/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev_ai_assisted/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-ansible/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-cloud/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-cpp/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-docker/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-dotnet/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/developer/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-go/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-java/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-js/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-make/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/devops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-php/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-python/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-ruby/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-rust/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/knowledge/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/multimedia/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/quantified-self/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/syscheck/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/tools/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/wsl_setup/Makefile`

### levonk.base_system
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/base_system/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/reboot_manager/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/syscheck/Makefile`

### levonk.common
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/ansible/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/ansible_builder/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/package/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/package_downloader/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/pip/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/reboot/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/reboot_management/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/syscheck/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/upgrade/Makefile`

### levonk.dev
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/dev_environment/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/dev_python/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/dev_rust/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/git/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/git_hooks/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/git_lfs/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/make/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/ssh/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/syscheck/Makefile`

### levonk.gamer
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/gaming_environment/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/gaming_launchers/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/steam/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/syscheck/Makefile`

### levonk.server_llmchat
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/open-webui/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/syscheck/Makefile`

### levonk.user_setup
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/chezmoi/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/local_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/remote_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/service_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/thick_shell/Makefile`

### levonk.vibeops
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/3d-printing/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/browsers/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/comms/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev_ai_assisted/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-ansible/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-cloud/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-cpp/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-docker/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-dotnet/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/developer/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-go/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-java/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-js/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-make/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/devops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-php/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-python/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-ruby/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-rust/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/knowledge/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/multimedia/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/quantified-self/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/syscheck/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/tools/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/wsl_setup/Makefile`

## Test Directories
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/test/Makefile`

## Molecule Test Directories
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/base_system/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/reboot_manager/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/syscheck/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/ansible/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/package/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/reboot/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/reboot_management/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/upgrade/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/dev_environment/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/git/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/dev/roles/make/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/gaming_environment/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/steam/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/open-webui/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/chezmoi/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/local_user/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/remote_user/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/service_user/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/thick_shell/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/tools/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/tools/molecule/graphical_enabled/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/wsl_setup/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/roles/user_setup/Makefile`

### common
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/install_gui_conditionally/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/open_firewall_port/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/pip/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/roles/vet_script_installer/Makefile`

### gamer
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/bluestacks_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/epic_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/game_performance_tuning/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/minecraft_forge_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/origin_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/steam_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/xbox_setup/Makefile`

### hardened
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/roles/harden_paranoid/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/roles/harden_noop/Makefile`

### server_llmchat
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/lite-llm/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/open-webui/Makefile`

### user_setup
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/chezmoi/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/local_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/service_user/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/thick_shell/Makefile`

### vibeops
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/3d-printing/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/comms/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-ansible/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-cloud/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-docker/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-dotnet/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/dev-go/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/devops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/syscheck/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/tools/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/wsl_setup/Makefile`

## Test Directories
- [ ] `test/Makefile`
- [ ] `ansible-galaxy/test/Makefile`
- [ ] `ansible-galaxy/collections/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/test/Makefile`

## Molecule Test Directories
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/molecule/default/Makefile`

## Documentation
- [ ] `docs/Makefile`
- [ ] `ansible-galaxy/docs/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/blueprint-namespace/docs/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/docs/Makefile`

## Verification Scripts
- [ ] `bin/verify-makefiles.sh`
- [ ] `bin/update-makefile-checklist.sh`

## Implementation Status
- [ ] All Makefiles exist
- [ ] All Makefiles follow standard structure
- [ ] All Makefiles pass linting
- [ ] All Makefiles have proper documentation
- [ ] All Makefile targets work as expected

### gamer
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/gamer/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/roles/gamer/test/Makefile`

### hardened
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/roles/harden_paranoid/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/roles/harden_paranoid/test/Makefile`

### server_llmchat
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/open-webui/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/roles/open-webui/test/Makefile`

### user_setup
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/user_setup/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/roles/user_setup/test/Makefile`

### vibeops
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/test/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/vibeops/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/roles/vibeops/test/Makefile`

## Test Directories
- [ ] `ansible-galaxy/test/Makefile`
- [ ] `ansible-galaxy/collections/test/Makefile`
- [ ] `test/Makefile`

## Molecule Test Directories
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/base_system/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/common/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/gamer/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/hardened/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/server_llmchat/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/user_setup/molecule/default/Makefile`
- [ ] `ansible-galaxy/collections/ansible_collections/levonk/vibeops/molecule/default/Makefile`

## Documentation
- [ ] `docs/Makefile`
- [ ] `ansible-galaxy/docs/Makefile`

## Verification Scripts
- [ ] `bin/verify-makefiles.sh`
- [ ] `bin/update-makefile-checklist.sh`

## Implementation Status
- [ ] All Makefiles exist
- [ ] All Makefiles follow standard structure
- [ ] All Makefiles pass linting
- [ ] All Makefiles have proper documentation
- [ ] All Makefile targets work as expected
