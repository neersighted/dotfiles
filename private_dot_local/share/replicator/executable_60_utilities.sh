#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Utilities"

# GDB Dashboard
git_sync https://github.com/cyrus-and/gdb-dashboard "$XDG_DATA_HOME/gdb-dashboard"

# ngrok
if ! command -v ngrok >/dev/null; then
  goversion=$(go version | awk '{print $4}')
  GOOS=${goversion%/*}
  GOARCH=${goversion#*/}

  important "Bootstrapping ngrok..."
  curl -sS "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-$GOOS-$GOARCH.zip" | funzip >"$HOME/.local/bin/ngrok"
  chmod +x "$HOME/.local/bin/ngrok"
  ngrok update
else
  important "Self-updating ngrok..."
  ngrok update
fi

# Pipeline Tools
cargo_install "runiq"
pipx_install "shell-functools"
go_get "mvdan.cc/xurls/v2/cmd/xurls"

# shfmt
go_get "mvdan.cc/sh/v3/cmd/shfmt"

important "Refreshing tldr pages..."
tldr --update

# vi: ft=sh
