# shellcheck shell=sh

# base
if [ -z "$LANG" ] || [ "$LANG" = C.UTF-8 ]; then
  export LANG="en_US.UTF-8"
fi
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

# c
if [ -z "$CC" ]; then
  export CC=cc
fi
if [ -z "$CXX" ]; then
  export CXX=c++
fi

# golang
export GO111MODULE=on
if [ -z "$GOBIN" ]; then
  export GOBIN="$XDG_DATA_HOME/go/bin"
fi
if [ -z "$GOENV_GOPATH_PREFIX" ]; then
  export GOENV_GOPATH_PREFIX="$XDG_DATA_HOME/go"
fi
if [ -z "$GOENV_ROOT" ]; then
  export GOENV_ROOT="$XDG_DATA_HOME/goenv"
fi
if [ -n "$GOENV_VERSION" ]; then
  export GOENV_VERSION=
fi
export PATH="$GOBIN:$GOENV_ROOT/shims:$GOENV_ROOT/bin:$PATH"

# nodejs
if [ -z "$NPM_CONFIG_USERCONFIG" ]; then
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
fi
if [ -z "$NPM_CONFIG_CACHE" ]; then
  export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
fi
if [ -z "$NODENV_ROOT" ]; then
  export NODENV_ROOT="$XDG_DATA_HOME/nodenv"
fi
if [ -n "$NODENV_VERSION" ]; then
  export NODENV_VERSION=
fi
export PATH="$NODENV_ROOT/shims:$NODENV_ROOT/bin:$PATH"

# python
if [ -z "$PIPX_HOME" ]; then
  export PIPX_HOME="$XDG_DATA_HOME/pipx"
fi
if [ -z "$PIPX_BIN_DIR" ]; then
  export PIPX_BIN_DIR="$XDG_DATA_HOME/pipx/bin"
fi
if [ -z "$PYENV_ROOT" ]; then
  export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
fi
if [ -n "$PYENV_VERSION" ]; then
  export PYENV_VERSION=
fi
export PATH="$PIPX_BIN_DIR:$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

# ruby
if [ -z "$GEM_SPEC_CACHE" ]; then
  export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
fi
if [ -z "$RBENV_ROOT" ]; then
  export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
fi
if [ -n "$RBENV_VERSION" ]; then
  export RBENV_VERSION=
fi
export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"

# rust
if [ -z "$CARGO_HOME" ]; then
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
fi
if [ -z "$RUSTUP_HOME" ]; then
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
fi
export PATH="$CARGO_HOME/bin:$PATH"

###

section() {
  printf '\033[0;35m%s\033[0m\n' "$@"
}

important() {
  printf '\033[0;32m%s\033[0m\n' "$@"
}

info() {
  printf '\033[0;33m%s\033[0m\n' "$@"
}

error() {
  printf '\033[0;31m%s\033[0m\n' "$@"
  exit 1
}

###

base64decode() {
  if command -v base64 >/dev/null; then
    base64 --decode
  elif command -v b64encode >/dev/null; then
    b64decode -r
  else
    error "unable to decode base64 data"
  fi
}

github_api() {
  if [ -n "$GITHUB_TOKEN" ]; then
    local auth_header="Authorization: token $GITHUB_TOKEN"
  elif [ -z "$GITHUB_WARNED" ]; then
    important "GITHUB_TOKEN not set, future API requests may be rate-limited!"
    export GITHUB_WARNED=1
  fi

  local url=$1; shift
  curl -s ${auth_header:+-H "$auth_header"} "$@" "https://api.github.com/$url"
}

# shellcheck disable=SC2120
selectversion() { # major, minor, patch
  awk -v major="$1" -v minor="$2" -v patch="$3" -F '.' '
    /^[ \t]*[0-9]+\.[0-9]+\.[0-9]+[ \t]*$/ {
      if ((major != "" && major != $1) ||
          (minor != "" && minor != $2) ||
          (patch != "" && patch != $3))
      {
        next
      }

      current = ($1 * 100 + $2) * 100 + $3
      if (current > max) {
        max = current
        chosen = $0
      }
    }
    END {
      gsub(/^[ \t]+/, "", chosen)
      gsub(/[ \t]+$/, "", chosen)
      print chosen
    }'
}

###

cargo_install() { # target, git
  if [ -z "$CARGO_INSTALLED" ]; then
    CARGO_INSTALLED=$(cargo install --list)
    export CARGO_INSTALLED
  fi

  if ! echo "$CARGO_INSTALLED" | grep -Eq "^$1"; then
    info "Installing $1 using cargo..."
    cargo install "$1" ${2:+--git "$2"}
  fi
}

git_sync() { # url, target
  local url=$1
  local target=$2

  local basename
  basename=$(basename "$target")

  if echo "$url" | grep -Fq 'github.com'; then
    local fragment=${url/'https://github.com/'/}
    local repo=${fragment/'.git'/}

    local branch commit
    branch=$(git -C "$target" rev-parse --abbrev-ref HEAD)
    commit=$(git -C "$target" rev-parse "$branch")

    local request latest
    request=$(github_api "repos/$repo/commits/$branch")
    latest=$(echo "$request" | jq -r .sha)

    if [ "$commit" != "$latest" ]; then
      local sync='true'
    fi
  else
    local sync='true'
  fi

  if [ "$sync" = 'true' ]; then
    info "Syncing $basename with git..."
    if [ -d "$target/.git" ]; then
      git -C "$target" pull --recurse-submodules
    else
      mkdir -p "$target"
      git -C "$target" init
      git -C "$target" remote add origin "$url"
      git -C "$target" fetch origin --depth 1
      git -C "$target" submodule update --recursive --init --depth 1
      git -C "$target" checkout -ft origin/master
    fi
  fi
}

github_sync() { # repo, file, target, executable
  local repo=$1
  local file=$2
  local target=$3
  local executable=$4

  local basename dirname
  basename=$(basename "$target")
  dirname=$(dirname "$target")
  if [ ! -d "$dirname" ]; then
    mkdir -p "$dirname"
  elif [ -L "$3" ]; then
    rm "$target"
  fi

  if [ -f "$target" ]; then
    mod_date=$(date -r "$target" +'%a, %d %b %Y %T %Z')
    local date_header="If-Modified-Since: $mod_date"
  fi

  local request request_len request_body request_status
  request=$(github_api "repos/$repo/contents/$file" ${date_header:+-H "$date_header"} -w '%{http_code}')
  request_len=$(echo "$request" | wc -l)
  request_body=$(echo "$request" | head -n$((request_len - 1)))
  request_status=$(echo "$request" | tail -n1)

  if [ "$request_status" -eq 200 ]; then
    info "Syncing $basename from Github..."

    local encoded_content
    encoded_content=$(echo "$request_body" | jq -r .content)
    echo "$encoded_content" | base64decode > "$3"

    if [ ! -x "$target" ] && [ "$executable" = 'true' ]; then
      chmod +x "$target"
    elif [ -x "$target" ] && [ "$executable" != 'true' ]; then
      chmod -x "$target"
    fi
  elif [ "$request_status" -ne 304 ]; then
    error "Error retreiving $repo from Github..."
  fi
}

go_get() { # target
  info "Fetching $(basename "$1") using go get..."
  go get "$1"
}

pipx_install() { # target, spec, pip args
  if [ -z "$PIPX_INSTALLED" ]; then
    PIPX_INSTALLED=$(pipx list)
    export PIPX_INSTALLED
  fi

  if ! echo "$PIPX_INSTALLED" | grep -Fq "$1"; then
    info "Installing $1 using pipx..."
    pipx install "${2:-$1}" ${3:+--pip-args="$3"}
  fi
}
