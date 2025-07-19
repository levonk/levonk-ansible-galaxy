import pytest
import testinfra

def test_port_open(host):
    port = host.ansible.get_variables().get('open_firewall_port_port', 8080)
    proto = host.ansible.get_variables().get('open_firewall_port_proto', 'tcp')
    s = host.socket("%s://0.0.0.0:%s" % (proto, port))
    assert s.is_listening
