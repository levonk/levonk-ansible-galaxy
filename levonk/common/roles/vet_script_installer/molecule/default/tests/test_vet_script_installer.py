import os
import pytest
import testinfra.utils.ansible_runner

# Testinfra host setup
HOSTS = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

@pytest.mark.parametrize('pkg', ['shellcheck', 'bat'])
def test_dependencies_installed(host, pkg):
    """Ensure vet dependencies are installed and in PATH."""
    assert host.exists(pkg)
    assert host.run(f'which {pkg}').rc == 0

@pytest.mark.parametrize('binary', ['vet'])
def test_vet_binary_installed(host, binary):
    """Ensure vet binary is present and executable."""
    bin_path = host.run(f'which {binary}').stdout.strip()
    assert bin_path
    assert host.file(bin_path).mode & 0o111

@pytest.mark.parametrize('script', ['test-script.sh'])
def test_script_vetted_and_present(host, script):
    """Ensure script is present after vetting."""
    # This assumes script is placed in /usr/local/bin or similar
    script_path = f'/usr/local/bin/{script}'
    f = host.file(script_path)
    assert f.exists
    assert f.user == 'root'
    assert f.mode & 0o111

# Audit log check (simplified, assumes /var/log/vet_script_installer.log or similar)
def test_audit_log_contains_emoji(host):
    log_path = '/var/log/vet_script_installer.log'
    if host.file(log_path).exists:
        content = host.file(log_path).content_string
        assert any(e in content for e in ['✅', '❌', '🛡️'])
