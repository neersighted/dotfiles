# shellcheck shell=sh

cargo_install() { # target, git
  if has_support "Rust"; then
    if [ -z "$CARGO_INSTALLED" ]; then
      CARGO_INSTALLED=$(cargo install --list)
    fi

    if ! echo "$CARGO_INSTALLED" | grep -Eq "^$1"; then
      CARGO_TARGET_DIR=$(mktemp -d)
      export CARGO_TARGET_DIR

      trap 'rm -rf "$CARGO_TARGET_DIR"' EXIT

      info "Installing $1 using cargo..."
      cargo install "$1" ${2:+--git "$2"}

      if [ -d "$CARGO_TARGET_DIR/release/build" ]; then
        find "$CARGO_TARGET_DIR/release/build" -name '*.fish' \
          -exec cp {} "$XDG_CONFIG_HOME/fish/completions" \;
      fi

      rm -rf "$CARGO_TARGET_DIR"
      trap - EXIT
    fi
  fi
}

gem_install() { # target
  if has_support "Ruby"; then
    if [ -z "$GEM_INSTALLED" ]; then
      GEM_INSTALLED=$(gem list --no-versions)
    fi

    if ! echo "$GEM_INSTALLED" | grep -Fq "$1"; then
      info "Installing $1 using gem..."
      gem install "$1"
    fi
  fi
}

git_sync() { # url, path
  if [ -d "$2" ]; then
    git -C "$2" pull
  else
    git clone --depth 1 --recurse-submodules --shallow-submodules "$1" "$2"
  fi
}

go_get() { # target
  if has_support "Golang"; then
    info "Fetching $1 using go get..."
    go get -u "$1"
  fi
}

npm_install() { # target
  if has_support "Node.js"; then
    if [ -z "$NPM_INSTALLED" ]; then
      NPM_INSTALLED=$(npm ls -g --depth 0)
    fi

    if ! echo "$NPM_INSTALLED" | grep -Fq "$1"; then
      info "Installing $1 using npm..."
      npm install -g "$1"
    fi
  fi
}

pipx_install() { # target, spec
  if has_support "Python"; then
    if [ -z "$PIPX_INSTALLED" ]; then
      PIPX_INSTALLED=$(pipx list)
    fi

    if ! echo "$PIPX_INSTALLED" | grep -Fq "$1"; then
      info "Installing $1 using pipx..."
      pipx install "$1" ${2:+--spec $2}
    fi
  fi
}
