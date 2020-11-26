#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Neovim"

if ! pyvenv_version neovim "$(pyenv version-name)"; then
  important "Creating neovim virtual environment for Python $(pyenv version-name)..."
  pyenv uninstall -f neovim
  pyenv virtualenv neovim
  PYENV_VERSION=neovim python -m pip install -U pip setuptools pynvim
fi

pipx_install "neovim-remote"
pipx_install "vim-vint"
go_get "github.com/rhysd/vim-startuptime"

# vi: ft=sh
