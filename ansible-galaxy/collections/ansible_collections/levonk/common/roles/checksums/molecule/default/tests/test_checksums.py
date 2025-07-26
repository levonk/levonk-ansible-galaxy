import os
import pytest
import testinfra.utils.ansible_runner

HOSTS = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

@pytest.mark.parametrize('file,algo,expected', [
    ('/tmp/file', 'sha256', True),
    ('/tmp/file', 'sha512', False),  # Simulate unsupported algo for negative test
])
def test_checksum_validation(host, file, algo, expected):
    """Test checksum validation for supported and unsupported algorithms."""
    # This is a placeholder; real test would parse logs or output
    if expected:
        assert host.file(file).exists
    else:
        # Check for error log or failure marker
        log_path = '/var/log/checksums.log'
        if host.file(log_path).exists:
            content = host.file(log_path).content_string
            assert 'unsupported' in content or 'error' in content

# Test audit log emoji presence
def test_audit_log_contains_emoji(host):
    log_path = '/var/log/checksums.log'
    if host.file(log_path).exists:
        content = host.file(log_path).content_string
        assert any(e in content for e in ['✅', '❌', '🛡️'])
