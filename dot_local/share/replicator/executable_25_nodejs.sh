#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Node.js"

important "Updating nodenv..."
git_sync https://github.com/nodenv/nodenv "$NODENV_ROOT"
git_sync https://github.com/nodenv/node-build "$NODENV_ROOT/plugins/node-build"
git_sync https://github.com/nodenv/nodenv-package-rehash "$NODENV_ROOT/plugins/nodenv-package-rehash"
git_sync https://github.com/nodenv/nodenv-default-packages "$NODENV_ROOT/plugins/nodenv-default-packages"

if ! $MAKE -C "$NODENV_ROOT/src" -q; then
  info "Building nodenv native extensions..."
  (
    cd "$NODENV_ROOT"
    ./src/configure
  )
  $MAKE -C "$NODENV_ROOT/src"
fi

NODEJS_VERSION=$(nodenv install -l | selectversion)
if ! nodenv versions --bare | grep -Fxq "$NODEJS_VERSION"; then
  important "Installing Node.js $NODEJS_VERSION..."
  NODENV_VERSION=system nodenv install -s "$NODEJS_VERSION"
  nodenv global "$NODEJS_VERSION"
fi

important "Updating Node.js packages..."
for node in $(nodenv versions --bare); do
  OLDIFS=$IFS
  IFS="$(printf '%b_' '\t\n')"
  IFS="${IFS%_}"
  for spec in $(NODENV_VERSION=$node npm -g outdated --json | jq -r 'to_entries[] | "\(.key) from \(.value.current) to \(.value.wanted)"'); do
    info "Updating $spec (Node.js $node)..."
    NODENV_VERSION=$node npm update -g "${spec%% *}"
  done
  IFS=$OLDIFS
done

# vi: ft=sh
