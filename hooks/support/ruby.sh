# shellcheck shell=sh

support_subsection "Ruby"

if [ -z "$RBENV_ROOT" ]; then
  export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
fi
export RBENV_VERSION=
export PATH="$RBENV_ROOT/bin:$PATH"

info "Syncing rbenv..."
git_sync https://github.com/rbenv/rbenv "$RBENV_ROOT"
git_sync https://github.com/rbenv/ruby-build "$RBENV_ROOT/plugins/ruby-build"

eval "$(rbenv init -)"

RUBY_VERSION="$(rbenv install -l | selectversion)"
if ! rbenv versions | grep -Fq "$RUBY_VERSION"; then
  info "Installing Ruby $RUBY_VERSION..."
  rbenv install -s "$RUBY_VERSION"
  info "Activating Ruby $RUBY_VERSION..."
  rbenv global "$RUBY_VERSION"
fi

info "Updating gem packages..."
gem update --system && gem update
