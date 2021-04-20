#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Ruby"

important "Updating rbenv..."
git_sync https://github.com/rbenv/rbenv "$RBENV_ROOT"
git_sync https://github.com/rbenv/ruby-build "$RBENV_ROOT/plugins/ruby-build"
git_sync https://github.com/rbenv/rbenv-default-gems "$RBENV_ROOT/plugins/rbenv-default-gems"
xenv_ext rbenv "$RBENV_ROOT"

RUBY_VERSION=$(rbenv install -L | selectversion)
if ! rbenv versions --bare | grep -Fxq "$RUBY_VERSION"; then
  important "Installing Ruby $RUBY_VERSION..."
  rbenv install -s "$RUBY_VERSION"
  rbenv global "$RUBY_VERSION"
fi

important "Updating Ruby gems..."
latest_rubygems=$(curl -sS https://rubygems.org/api/v1/gems/rubygems-update.json | jq -r '.version')
for ruby in $(rbenv versions --bare); do
  local_rubygems=$(RBENV_VERSION=$ruby gem --version)
  if [ "$local_rubygems" != "$latest_rubygems" ]; then
    info "Updating RubyGems from $local_rubygems to $latest_rubygems ($ruby)..."
    RBENV_VERSION=$ruby gem update --system
  fi

  OLDIFS=$IFS
  IFS="$(printf '%b_' '\t\n')"
  IFS="${IFS%_}"
  for spec in $(RUBY_VERSION=$ruby gem outdated | sed -E 's/(.+) \((.+) < (.+)\)/\1 from \2 to \3/'); do
    info "Updating $spec (Ruby $ruby)..."
    RUBY_VERSION=$ruby gem update "${spec%% *}"
  done
  IFS=$OLDIFS
done

# vi: ft=sh
