# shellcheck disable=SC2039

cargo_install() {
  if has_support "Rust"; then
    local target=$1
    local git=$2

    if [ -z "$CARGO_INSTALLED" ]; then
      CARGO_INSTALLED=$(cargo install --list)
    fi

    if ! echo "$CARGO_INSTALLED" | grep -Eq "^$target"; then
      CARGO_TARGET_DIR=$(mktemp -d)
      export CARGO_TARGET_DIR

      trap 'rm -rf "$CARGO_TARGET_DIR"' EXIT

      info "Installing $target using cargo..."
      cargo install "$target" ${git:+--git "$git"}

      if [ -d "$CARGO_TARGET_DIR/release/build" ]; then
        local completion
        completion=$(find "$CARGO_TARGET_DIR/release/build" -name '*.fish')
        if [ -n "$completion" ]; then
          info "Installing fish completion for $target..."
          cp "$completion" "$XDG_CONFIG_HOME/fish/completions"
        fi
      fi

      rm -rf "$CARGO_TARGET_DIR"
      trap - EXIT
    fi
  fi
}

gem_install() {
  if has_support "Ruby"; then
    local target=$1

    if [ -z "$GEM_INSTALLED" ]; then
      GEM_INSTALLED=$(gem list --no-versions)
    fi

    if ! echo "$GEM_INSTALLED" | grep -Fq "$target"; then
      info "Installing $target using gem..."
      gem install "$target"
    fi
  fi
}

git_sync() {
  local url=$1
  local path=$2

  if [ -d "$path" ]; then
    git -C "$path" pull
  else
    git clone --depth 1 --recurse-submodules --shallow-submodules "$url" "$path"
  fi
}

go_get() {
  if has_support "Golang"; then
    local target=$1

    info "Fetching $target using go get..."
    go get -u "$target"
  fi
}

npm_install() {
  if has_support "Node.js"; then
    local target=$1

    if [ -z "$NPM_INSTALLED" ]; then
      NPM_INSTALLED=$(npm ls -g --depth 0)
    fi

    if ! echo "$NPM_INSTALLED" | grep -Fq "$target"; then
      info "Installing $target using npm..."
      npm install -g "$target"
    fi
  fi
}

pipx_install() {
  if has_support "Python"; then
    local target=$1
    local spec=$2

    if [ -z "$PIPX_INSTALLED" ]; then
      PIPX_INSTALLED=$(pipx list)
    fi

    if ! echo "$PIPX_INSTALLED" | grep -Fq "$target"; then
      info "Installing $target using pipx..."
      if [ -n "$spec" ]; then
        pipx install --spec "$spec" "$target"
      else
        pipx install "$target"
      fi
    fi
  fi
}
