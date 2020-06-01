#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Neovim"

if ! pyenv versions --bare | grep -Fxq "neovim"; then
  important "Creating neovim virtual environment..."
  pyenv virtualenv neovim
  PYENV_VERSION=neovim python -m pip install -U pip setuptools
  PYENV_VERSION=neovim python -m pip install pynvim
fi

pipx_install "neovim-remote"
pipx_install "vim-vint"

# vi: ft=sh
