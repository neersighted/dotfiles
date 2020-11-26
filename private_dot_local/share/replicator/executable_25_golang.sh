#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Golang"

important "Updating goenv..."
git_sync https://github.com/syndbg/goenv "$GOENV_ROOT"
xenv_ext goenv "$GOENV_ROOT"

GOLANG_VERSION=$(goenv install -l | selectversion)
if ! goenv versions --bare | grep -Fxq "$GOLANG_VERSION"; then
  important "Installing Golang $GOLANG_VERSION..."
  goenv install -s "$GOLANG_VERSION"
  goenv global "$GOLANG_VERSION"
fi

go_get "golang.org/x/tools/gopls@latest"

# vi: ft=sh
