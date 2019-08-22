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
git_sync https://github.com/nodenv/nodenv-package-json-engine "$NODENV_ROOT/plugins/nodenv-package-json-engine"
git_sync https://github.com/nodenv/nodenv-default-packages "$NODENV_ROOT/plugins/nodenv-default-packages"

cat <<EOF >"$NODENV_ROOT/default-packages"
flow
lerna
neovim
npm-check
pnpm
EOF

eval "$(nodenv init -)"

NODENV_INSTALLED=$(nodenv versions --skip-aliases --bare)

NODEJS_VERSION=$(nodenv install -l | selectversion)
if ! nodenv versions | grep -Fq "$NODEJS_VERSION"; then
  info "Installing Node.js $NODEJS_VERSION..."
  env NODENV_VERSION=system nodenv install -s "$NODEJS_VERSION"
  info "Activating Node.js $NODEJS_VERSION..."
  nodenv global "$NODEJS_VERSION"
fi

for node in $NODENV_INSTALLED;  do
  for target in $(NODENV_VERSION=$node npm -g outdated --parseable --depth=0); do
    wanted=$(echo "$target" | cut -d: -f2)
    installed=$(echo "$target" | cut -d: -f3)

    ! [ "$(echo "$wanted" | cut -d@ -f1)" = npm ] || continue

    info "Updating $installed to $wanted ($node)..."
    NODENV_VERSION=$node npm install -g "$wanted"
  done
done
