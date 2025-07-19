import os
import pytest
import testinfra.utils.ansible_runner

# Testinfra hosts
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

def test_timezone(host):
    tz = host.check_output('date +%Z')
    # Accept both short and long forms for robustness
    assert tz in ["EDT", "EST", "America/New_York"]

def test_ntp_service(host):
    if host.system_info.type == 'linux':
        s = host.service("ntp")
        assert s.is_enabled
        assert s.is_running
    elif host.system_info.type == 'darwin':
        s = host.service("org.ntp.ntpd")
        assert s.is_enabled
        assert s.is_running
    elif host.system_info.type == 'windows':
        s = host.service("w32time")
        assert s.is_enabled
        assert s.is_running

def test_ntp_config(host):
    if host.system_info.type == 'linux':
        f = host.file("/etc/ntp.conf")
        assert f.exists
        assert f.contains("time.google.com")
        assert f.contains("time.cloudflare.com")
    elif host.system_info.type == 'darwin':
        f = host.file("/private/etc/ntp.conf")
        assert f.exists
        assert f.contains("time.google.com")
        assert f.contains("time.cloudflare.com")
    elif host.system_info.type == 'windows':
        cmd = host.run("w32tm /query /peers")
        assert "time.google.com" in cmd.stdout or "time.cloudflare.com" in cmd.stdout
