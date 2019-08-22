# shellcheck shell=sh

cargo_install() { # target, git
  if has_support "Rust"; then
    if [ -z "$CARGO_INSTALLED" ]; then
      CARGO_INSTALLED=$(cargo install --list)
    fi

    if ! echo "$CARGO_INSTALLED" | grep -Eq "^$1"; then
      info "Installing $1 using cargo..."
      cargo install "$1" ${2:+--git "$2"}
    fi
  fi
}

fetch_url() { # url, path, executable
  info "Fetching $1 with curl..."
  mkdir -p "$(dirname "$2")"
  rm -f "$2"
  curl "$1" -o "$2"
  if [ "$3" = true ]; then
    chmod +x "$2"
  fi
}

git_sync() { # url, path
  info "Syncing $1 with git..."
  if [ -d "$2" ]; then
    git -C "$2" pull
  else
    git clone --depth 1 --recurse-submodules --shallow-submodules "$1" "$2"
  fi
}

go_get() { # target, module
  if has_support "Golang"; then
    info "Fetching $1 using go get..."
    (
      MOD=$(mktemp -d)
      trap 'rm -rf $MOD' EXIT

      cd "$MOD" || exit 1
      go mod init tmp
      go get "$1"
    )
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
