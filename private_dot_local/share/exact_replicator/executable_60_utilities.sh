#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Utilities"

# cookiecutter
pipx_install "cookiecutter"

# gdb
git_sync https://github.com/cyrus-and/gdb-dashboard "$XDG_DATA_HOME/gdb-dashboard"
pipx_install "gdbgui"

# http-prompt
pipx_install "http-prompt"

# Pipeline Tools
pipx_install "shell-functools"
go_get "mvdan.cc/xurls/v2/cmd/xurls"

# shfmt
go_get "mvdan.cc/sh/v3/cmd/shfmt"

if [ "$(dirname "$(command -v chezmoi)")" = "$HOME/.local/bin" ]; then
  if [ "$(which -a chezmoi | wc -l)" -gt 1 ]; then
    important "Switching to system-managed chezmoi..."
    rm "$HOME/.local/bin/chezmoi"
  else
    important "Self-updating bootstrapped chezmoi..."
    "$HOME/.local/bin/chezmoi" upgrade
  fi
fi

# vi: ft=sh
