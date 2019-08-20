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
git_sync https://github.com/aripollak/rbenv-bundler-ruby-version "$RBENV_ROOT/plugins/rbenv-bundler-ruby-version"
git_sync https://github.com/tpope/rbenv-communal-gems "$RBENV_ROOT/plugins/rbenv-communal-gems"
git_sync https://github.com/rbenv/rbenv-default-gems "$RBENV_ROOT/plugins/rbenv-default-gems"
git_sync https://github.com/rbenv/rbenv-each "$RBENV_ROOT/plugins/rbenv-each"

cat <<EOF >"$RBENV_ROOT/default-gems"
bundler
foreman
looksee
pry
rib
rspec
rubocop
EOF

eval "$(rbenv init -)"

RUBY_VERSION="$(rbenv install -l | selectversion)"
if ! rbenv versions | grep -Fq "$RUBY_VERSION"; then
  info "Installing Ruby $RUBY_VERSION..."
  rbenv install -s "$RUBY_VERSION"
  info "Activating Ruby $RUBY_VERSION..."
  rbenv global "$RUBY_VERSION"
fi

info "Updating gems..."
rbenv each gem update --system
rbenv each gem update
