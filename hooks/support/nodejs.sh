# shellcheck shell=sh

support_subsection "Node.js"

if [ -z "$NODENV_ROOT" ]; then
  export NODENV_ROOT="$XDG_DATA_HOME/nodenv"
fi
export NODENV_VERSION=
export PATH="$NODENV_ROOT/bin:$PATH"

info "Syncing nodenv..."
git_sync https://github.com/nodenv/nodenv "$NODENV_ROOT"
git_sync https://github.com/nodenv/node-build "$NODENV_ROOT/plugins/node-build"
git_sync https://github.com/nodenv/nodenv-package-rehash "$NODENV_ROOT/plugins/nodenv-package-rehash"

eval "$(nodenv init -)"

NODEJS_VERSION=$(nodenv install -l | selectversion)
if ! nodenv versions | grep -Fq "$NODEJS_VERSION"; then
  info "Installing Node.js $NODEJS_VERSION..."
  env PYENV_VERSION=system nodenv install -s "$NODEJS_VERSION"
  info "Activating Node.js $NODEJS_VERSION..."
  nodenv global "$NODEJS_VERSION"
fi

info "Updating npm packages..."
npm update -g
