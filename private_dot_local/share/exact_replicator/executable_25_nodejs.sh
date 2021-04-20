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
xenv_ext nodenv "$NODENV_ROOT"

NODEJS_VERSION=$(curl -sL "https://nodejs.org/dist/index.tab" | awk -F '\t' 'FNR > 1 { if ($10 != "-") { print $1 } }' | selectversion)
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
  for spec in $(NODENV_VERSION=$node npm outdated -g --json | jq -r 'to_entries[] | "\(.key) from \(.value.current) to \(.value.latest)"'); do
    info "Updating $spec (Node.js $node)..."
    NODENV_VERSION=$node npm install -g "${spec%% *}@latest"
  done
  IFS=$OLDIFS
done

# vi: ft=sh
