# Package Management Migration to levonk.common.package

*Created: 2025-07-31*
*Status: In Progress*

## Overview
This document outlines the tasks required to migrate all direct package manager calls to use the `levonk.common.package` role. This will provide a unified interface for package management across all supported platforms.

## Migration Guidelines

### Standard Pattern
```yaml
- name: Install package
  include_role:
    name: levonk.common.package
  vars:
    package_name: package_name
    state: present  # or 'latest', 'absent'
```

### Multiple Packages
```yaml
- name: Install multiple packages
  include_role:
    name: levonk.common.package
  vars:
    packages:
      - name: package1
        state: present
      - name: package2
        state: latest
```

### Version Pinning
```yaml
- name: Install specific version
  include_role:
    name: levonk.common.package
  vars:
    package_name: package_name
    version: 1.2.3
```

## Migration Tasks

### 1. Server LLM Chat Collection
- [x] **server_llmchat/roles/lite-llm/**
  - [x] `tasks/install-lite-llm.yml`: Replace `ansible.builtin.apt`
  - [x] `tasks/install-open-webui.yml`: Replace `ansible.builtin.apt`

- [x] **server_llmchat/roles/open-webui/**
  - [x] `tasks/install.yml`: Replace `ansible.builtin.apt`

### 2. VibeOps Collection

#### Knowledge Role
- [x] **roles/knowledge/tasks/**
  - [x] `obsidian.yml`: Replace `ansible.builtin.apt`
  - [x] `microsoft_copilot.yml`: Check for any package manager usage

#### Tools Role
- [x] **roles/tools/tasks/virtualization/**
  - [x] `virtualbox.yml`: Replace `ansible.builtin.apt`
  - [x] `vagrant.yml`: Replace `ansible.builtin.apt`

- [x] **roles/tools/tasks/utils/**
  - [x] `copier.yml`: Replace `ansible.builtin.apt`

- [x] **roles/tools/tasks/editors/**
  - [x] `sublime_text.yml`: Replace `ansible.builtin.apt` (lines 17, 42)

- [x] **roles/tools/tasks/diagram_viz/**
  - [x] `archi-diagrams.yml`: Replace `ansible.builtin.apt` and `ansible.builtin.dnf`

- [x] **roles/tools/tasks/ui_tools/**
  - [x] `espanso.yml`: Check for any package manager usage

- [x] **roles/tools/tasks/shell_terminal/**
  - [x] `git_friendly.yml`: Check for any package manager usage

#### Dev-AI Assisted Role
- [x] **roles/dev_ai_assisted/tasks/**
  - [x] `install_vscode.yml`: Replace `ansible.builtin.apt`
  - [x] `install_cursor.yml`: Replace `ansible.builtin.apt`
  - [x] `install_gcloud_sdk.yml`: Replace `ansible.builtin.apt`
  - [x] `install_cline.yml`: Replace `ansible.builtin.apt`

#### Multimedia Role
- [x] **roles/multimedia/tasks/**
  - [x] `vlc.yml`: Replace `ansible.builtin.apt`
  - [x] `obs_studio.yml`: Replace `ansible.builtin.apt`
  - [x] `imagemagick.yml`: Replace `ansible.builtin.apt`
  - [x] `gimp.yml`: Replace `ansible.builtin.apt`
  - [x] `ffmpeg.yml`: Replace `ansible.builtin.apt`
  - [x] `cava.yml`: Replace `ansible.builtin.apt`
  - [x] `audacity.yml`: Replace `ansible.builtin.apt`

#### Dev-Docker Role
- [x] **roles/dev-docker/tasks/**
  - [x] `dive.yml`: Replace `ansible.builtin.apt` and `ansible.builtin.dnf`

#### Dev-Make Role
- [x] **roles/dev-make/tasks/debug/**
  - [x] `remake.yml`: Replace `ansible.builtin.apt` and `ansible.builtin.dnf`

#### Dev-JS Role
- [x] **roles/dev-js/tasks/**
  - [x] `webstorm.yml`: Replace `ansible.builtin.apt`

#### Comms Role
- [x] **roles/comms/tasks/**
  - [x] `zoom.yml`: Replace `ansible.builtin.apt`
  - [x] `telegram.yml`: Replace `ansible.builtin.apt`
  - [x] `slack.yml`: Replace `ansible.builtin.apt`
  - [x] `signal.yml`: Replace `ansible.builtin.apt`

### 3. Hardened Collection
- [x] **roles/harden_moderate/tasks/extra/**
  - [x] `linux.yml`: Replace `ansible.builtin.apt` and `ansible.builtin.yum`

### 4. Base System Collection
- [x] **roles/base_system/tasks/system/**
  - [x] `graphical.yml`: Replace `ansible.builtin.apt`

### 5. Common Collection
- [x] **roles/checksums/tasks/**
  - [x] `main.yml`: Replace `ansible.builtin.apt` and `ansible.builtin.yum`

## Verification
After completing the migration:
- [ ] Run tests for all affected roles
- [ ] Verify package installation on all supported platforms

