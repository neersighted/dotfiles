#!/bin/sh

set -e

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

# homebrew
if [ -z "$HOMEBREW_BUNDLE_FILE" ]; then
  export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/brew/Brewfile"
fi

# c
if [ -z "$CC" ]; then
  export CC=cc
fi
if [ -z "$CXX" ]; then
  export CXX=c++
fi
if [ -z "$MAKE" ]; then
  if command -v gmake >/dev/null; then
    export MAKE=gmake
  else
    export MAKE=make
  fi
fi

# dotnet
if [ -z "$DOTNET_ROOT" ]; then
  export DOTNET_ROOT="$XDG_DATA_HOME/dotnet"
fi
if [ -z "$DOTNET_TOOL_PATH" ]; then
  export DOTNET_TOOL_PATH="$DOTNET_ROOT/tools"
fi
if [ -z "$NUGET_PACKAGES" ]; then
  export NUGET_PACKAGES="$XDG_DATA_HOME/nuget"
fi
PATH="$DOTNET_TOOL_PATH:$DOTNET_ROOT:$PATH"

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
PATH="$GOBIN:$GOENV_ROOT/shims:$GOENV_ROOT/bin:$PATH"

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
PATH="$NODENV_ROOT/shims:$NODENV_ROOT/bin:$PATH"

# python
if [ -z "$PIPX_HOME" ]; then
  export PIPX_HOME="$XDG_DATA_HOME/pipx"
fi
if [ -z "$PIPX_BIN_DIR" ]; then
  export PIPX_BIN_DIR="$XDG_DATA_HOME/pipx/bin"
fi
if [ -z "$POETRY_HOME" ]; then
  export POETRY_HOME="$XDG_DATA_HOME/pypoetry"
fi
if [ -z "$PYENV_ROOT" ]; then
  export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
fi
if [ -n "$PYENV_VERSION" ]; then
  export PYENV_VERSION=
fi
PATH="$PIPX_BIN_DIR:$POETRY_HOME/bin:$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

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
PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"

# rust
if [ -z "$CARGO_HOME" ]; then
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
fi
if [ -z "$RUSTUP_HOME" ]; then
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
fi
PATH="$CARGO_HOME/bin:$PATH"

# local tools
PATH="$HOME/.local/bin:$PATH"

# dedupe path
PATH=$(printf '%s' "$PATH" | awk -v RS=: '!a[$0]++' | paste -s -d: -)

###

section() {
  # cyan
  printf '\033[0;36m%s\033[0m\n' "$@"
}

print() {
  # blue
  printf '\033[0;34m%s\033[0m\n' "$@"
}

important() {
  # green
  printf '\033[0;32m%s\033[0m\n' "$@"
}

info() {
  # yellow
  printf '\033[0;33m%s\033[0m\n' "$@"
}

warn() {
  # magenta
  printf '\033[0;35m%s\033[0m\n' "$@" >&2
}

error() {
  # red
  printf '\033[0;31m%s\033[0m\n' "$@" >&2
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

# shellcheck disable=SC2120
selectversion() { # major, minor, patch
  awk -v major="$1" -v minor="$2" -v patch="$3" '
    BEGIN {
      FS = "."
      OFS = "."
    }
    /^[ \t]*v?[0-9]+\.[0-9]+\.[0-9]+[ \t]*$/ {
      if ($1 ~ /^v/) {
        $1 = substr($1, 2)
      }

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

pyvenv_version() {
  pyenv versions --bare --skip-aliases | awk -v venv="$1" -v version="$2" '
    BEGIN {
      FS = "/"
      missing = 1
    }
    $2 == "envs" && NF == 3 {
      if ($1 == version && $3 == venv) {
        missing = 0
      }
    }
    END {
      exit missing
    }
  '
}

xenv_ext() {
  name=$1
  root=$2

  if ! $MAKE -C "$root/src" -q; then
    info "Building $name native extensions..."
    (
      cd "$root" || exit 1
      ./src/configure
    )
    $MAKE -C "$root/src"
  fi
}

###

git_sync() { # url, target
  url=$1
  target=$2

  if [ -d "$target/.git" ] && printf '%s' "$url" | grep -Fq 'github.com'; then
    repo=$(printf '%s' "$url" | sed 's#https://github.com/##; s/.git$//')
    branch=$(git -C "$target" rev-parse --abbrev-ref HEAD)
    commit=$(git -C "$target" rev-parse "$branch")

    latest=$(gh api "repos/$repo/commits/$branch" --jq '.sha')

    if [ "$commit" != "$latest" ]; then
      sync='true'
    else
      sync='false'
    fi
  else
    sync='true'
  fi

  if [ "$sync" = 'true' ]; then
    info "Syncing $(basename "$target") with Git..."
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
  repo=$1
  file=$2
  target=$3
  executable=$4

  basename=$(basename "$target")
  dirname=$(dirname "$target")
  if [ ! -d "$dirname" ]; then
    mkdir -p "$dirname"
  elif [ -L "$3" ]; then
    rm "$target"
  fi

  if [ -f "$target" ]; then
    mod_date=$(date -r "$target" +'%a, %d %b %Y %T %Z')
    date_header="If-Modified-Since: $mod_date"
  else
    date_header=
  fi

  response=$(gh api "repos/$repo/contents/$file" ${date_header:+-H "$date_header"} --include --jq '.content' 2>/dev/null || true)
  response_headers=$(printf '%s' "$response" | sed '/^[[:space:]]*$/,$d')
  response_status=$(printf '%s' "$response_headers" | sed '2,$d; s#HTTP/[0-9]\.[0-9] \([0-9]\{3\}\) .*#\1#')
  response_content=$(printf '%s' "$response" | sed '1,/^[[:space:]]*$/d')

  if [ "$response_status" -eq 200 ]; then
    info "Syncing $basename from Github..."

    printf '%s' "$response_content" | base64decode >"$3"

    if [ ! -x "$target" ] && [ "$executable" = 'true' ]; then
      chmod +x "$target"
    elif [ -x "$target" ] && [ "$executable" != 'true' ]; then
      chmod -x "$target"
    fi
  elif [ "$response_status" -ne 304 ]; then
    error "Error retreiving $repo from Github..."
  fi
}

###

cargo_install() { # target, git
  if [ -z "$CARGO_INSTALLED" ]; then
    CARGO_INSTALLED=$(cargo install --list)
    export CARGO_INSTALLED
  fi

  if ! printf '%s' "$CARGO_INSTALLED" | grep -Eq "^$1"; then
    info "Installing $1 with cargo..."
    cargo install "$1" ${2:+--git "$2"}
  fi
}

dotnet_tool_install() { # target
  if [ -d "$DOTNET_TOOL_PATH/.store/$1" ]; then
    info "Updating $1 with dotnet tool update..."
    dotnet tool update --tool-path "$DOTNET_TOOL_PATH" "$1"
  else
    info "Installing $1 with dotnet tool install..."
    dotnet tool install --tool-path "$DOTNET_TOOL_PATH" "$1"
  fi
}

go_get() { # target
  info "Fetching $(basename "$1") with go get..."
  go get "$1"
}

pipx_install() { # target, spec, pip args
  if [ -z "$PIPX_INSTALLED" ]; then
    PIPX_INSTALLED=$(pipx list)
    export PIPX_INSTALLED
  fi

  if ! printf '%s' "$PIPX_INSTALLED" | grep -Fq "$1"; then
    info "Installing $1 with pipx..."
    pipx install "${2:-$1}" ${3:+--pip-args="$3"}
  fi
}
