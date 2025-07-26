import os
import pytest
import testinfra

@pytest.mark.parametrize("cmd", ["nvim --version", "nvim --headless +qall"])
def test_neovim_installed_and_runs(host, cmd):
    result = host.run(cmd)
    assert result.rc == 0, f"Neovim command '{cmd}' failed: {result.stderr}"
    if cmd == "nvim --version":
        assert "NVIM" in result.stdout, "Neovim version output missing 'NVIM'"

def test_neovim_config_dir(host):
    config_dir = host.check_output("echo ~") + "/.config/nvim"
    assert host.file(config_dir).is_directory, f"Neovim config dir {config_dir} missing"
