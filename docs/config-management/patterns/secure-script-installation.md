# Secure Script/Plugin Installation Pattern (with vet)

## Problem
Traditionally, scripts/plugins are installed by piping downloaded code directly to a shell (e.g., `curl | sh`). This is insecure and exposes systems to supply-chain attacks, malicious code, and unintentional system compromise.

## Solution: Vetting with [vet](https://github.com/vet-run/vet)

**Pattern:**
1. Download the script to a local file using a secure method (e.g., `ansible.builtin.get_url`).
2. Run `vet --non-interactive <script>` to statically analyze the script for suspicious or dangerous code.
3. Only execute the script if `vet` returns a successful (0) exit code.

### Example (Ansible)
```yaml
- name: Download Oh My Zsh install script
  ansible.builtin.get_url:
    url: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    dest: /tmp/ohmyzsh-install.sh
    mode: '0755'

- name: Vet Oh My Zsh install script (non-interactive)
  ansible.builtin.shell: vet --non-interactive /tmp/ohmyzsh-install.sh
  register: vet_result
  failed_when: vet_result.rc != 0

- name: Install Oh My Zsh script only if vetted
  ansible.builtin.shell: /tmp/ohmyzsh-install.sh --unattended
  when: vet_result.rc == 0
```

## Advantages
- Prevents execution of potentially malicious scripts.
- Enforces compliance with security best practices.
- Auditable and repeatable for compliance documentation.

## When to Use
- Any time you need to install a shell plugin, framework, or third-party script (e.g., Oh My Zsh, bash-it, starship, etc.).
- Any automation that previously used `curl | sh` or similar patterns.

## Requirements
- `vet` must be installed and available in the system path.
- Script must be downloaded to disk before execution.

## See Also
- [vet project on GitHub](https://github.com/vet-run/vet)
- [ShellCheck](https://www.shellcheck.net/) for additional static analysis
- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices/)

---
**Pattern maintained by:** DevSecOps/Config Management Team
