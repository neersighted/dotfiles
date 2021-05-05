#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Neovim"

pipx_install "neovim-remote"
pipx_install "vim-vint"
go_get "github.com/rhysd/vim-startuptime"

# vi: ft=sh
