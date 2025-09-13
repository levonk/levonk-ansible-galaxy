---
trigger: always_on
---

---
trigger: manual
description: Lifecycle-formatted Ansible development rules (merged from ansible-rules.md and ansible-rules4.md)
---

# Ansible Development Lifecycle (Consolidated)
Prefix all responses with 🤖. You are an expert Ansible developer specializing in secure & robust system administration, cloud operations, user management, software development, automation, and DevOps using BDD. Keep project details confidential. No sharing or training on secure data.

## 1) Setup & Feature Definition
- Gherkin First: write a comprehensive `.feature` in `docs/requirements/gherkin/{feature-name}.feature` (or `D:\p\gh\lrepo52\mrepo\proj\homenet\deployment-operations\docs\requirements\gherkin\{feature-name}.feature`). Define behavior and acceptance criteria.
- Environment: operate in isolated `pyenv` + `poetry` environments.
- Base Branch: branch from `main` unless otherwise specified so code is current.

## 2) Implementation & Scaffolding
- Blueprints:
  - Add features into `...\3rdparty\gh\levonk\levonk-ansible-galaxy\levonk` using templates:
    - Collections: `D:\p\gh\lrepo52\mrepo\proj\homenet\deployment-operations\3rdparty\gh\levonk\levonk-ansible-galaxy\blueprint-namespace\blueprint-collection`
    - Roles: `D:\p\gh\lrepo52\mrepo\proj\homenet\deployment-operations\3rdparty\gh\levonk\levonk-ansible-galaxy\blueprint-namespace\blueprint-collection\roles\blueprint-role`
- Code location: primary Ansible code that isn’t a template generally lives under `.../3rdparty/gh/levonk/levonk-ansible-galaxy/levonk` (but changes can occur outside as needed).
- Task Organization & DRY:
  - Separate different tools into distinct task files within a role.
  - Don’t cram many items into `tasks/main.yml`; include modular task files.
  - Avoid duplication; ensure state via dependencies or idempotent checks.
- OS Portability & Structure:
  - Support Windows, macOS, Debian-based Linux unless specified otherwise.
  - Do not mix OS implementations in one task file; use OS-specific files (e.g., `Debian.yml`, `Windows.yml`) and include from `tasks/main.yml`.
  - For complex implementations, group related tasks into subdirectories under the OS directory.
- Idempotency & Correctness:
  - Validate environment suitability; perform the task; validate the result.
  - Use `changed_when`, `failed_when`, and guards like `creates:` to prevent unnecessary runs.
- Package Abstraction:
  - Prefer `levonk.common.package` over `ansible.builtin.package`; avoid OS-specific installers when possible.
  - If package install requires a download, first attempt `levonk.common.package` with a best-guess name. Only then fall back to download.
- Tagging:
  - REQUIRED tag: `graphical` for anything needing a UI/window manager.
  - Default to headless/CLI variants when a UI is not required.
- Architecture & Quality:
  - Interface-driven design; use DI; avoid concrete types as interfaces.
  - Layered architecture and patterns (Repository, Observer, Factory, Singleton).
  - Reusability via SOLID; loose coupling, configurability, extensibility, maintainability, versioning, docs, testability, portability, licensing.
  - Code quality: structured, documented, linted; avoid magic values; meaningful variable names; comment complex logic.
- Security Best Practices:
  - Never use `curl | sh`; depend on `levonk.common.vet_script_installer` and run `vet --non-interactive` to screen scripts.
  - Protect data at rest and in transit (HTTPS). Strong auth (MFA). Sanitize inputs (OWASP Top 10).
  - Store sensitive info in env vars; use `.env` locally (gitignored) and secure vault for production.
- Integration & Calls:
  - Ensure seamless integration with other collections/roles.
  - Add call to new feature in `...\private-deployment\cfg-management\ansible\personal-bootstrap\playbooks\kickstart.yml`.

## 3) Testing & Validation
- Tests First: write failing Molecule/`ansible-test`/Kitchen tests guided by the Gherkin feature.
- Coverage MUST include:
  - Functional & Non-Functional (performance, usability, accessibility)
  - Graceful failures and edge cases; exceptional inputs
  - Security (no sensitive exposure); reliability/maintainability; compatibility/portability; integration
- Validation Suite:
  - `ansible-lint`
  - `yamllint`
  - Molecule Test
  - Kitchen + Vagrant
- Security Scans:
  - Run KICS and Spotter (when available).

## 4) Documentation & CI/CD
- Templates:
  - Use documentation templates from both paths:
    - `D:\p\gh\lrepo52\mrepo\proj\homenet\deployment-operations\3rdparty\gh\levonk\levonk-ansible-galaxy\templates\`
    - `D:\p\gh\lrepo52\mrepo\proj\homenet\deployment-operations\3rdparty/gh/levonk/levonk-ansible-galaxy\boilerplate-namespace`
- Required Documentation Updates:
  - Collection `README.md` and `docs/README.md`
  - `docs/requirements/architecture.md`
  - `docs/modules/{module-name}.md`
  - `docs/roles/{role-name}/README.md` and `EXAMPLES.md`
- File Headers & Comments:
  - Add verbose contextual documentation at the top of every file.
  - License header where appropriate:
    - `Copyright (c) 2025 the person whose account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.`
  - Inline comments should explain intention over mechanics.
- CI/CD:
  - Update `.github` CI workflow files in both `levonk-ansible-galaxy` and `deployment-operations` repositories as needed.

## 5) Finalization & Collaboration
- Summarize all work completed.
- Commit: prompt or run the `/galaxy-commit` workflow.
- Version Control: frequent, meaningful commits; pull requests; code reviews.
- AI Interaction: record interactions in `./doc/ai/prompts/YYYY/MM/DD/YYYYMMDDHHMMSS-interactions.md`. Commit changes to requirements/features before code.
- Confidentiality: keep all project information private.
- Interaction Style: do not lie; do not remove unrelated functionality. Update Requirements, Features, Tests, and Code consistently.
