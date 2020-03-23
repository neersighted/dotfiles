# shellcheck shell=sh

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

if [ -z "$CC" ]; then
  export CC=cc
fi
if [ -z "$CXX" ]; then
  export CXX=c++
fi

###

section() {
  printf "\\033[0;33m%s\\033[0m\\n" "$@"
}

info() {
  printf "\\033[0;32m%s\\033[0m\\n" "$@"
}

important() {
  printf "\\033[0;35m%s\\033[0m\\n" "$@"
}

error() {
  printf "\\033[0;31m%s\\033[0m\\n" "$@"
  exit 1
}

###

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
  if ! cargo install --list | grep -Eq "^$1"; then
    info "Installing $1 using cargo..."
    cargo install "$1" ${2:+--git "$2"}
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
  info "Fetching $1 using go get..."
  (
    MOD=$(mktemp -d)
    trap 'rm -rf $MOD' EXIT

    cd "$MOD" || exit 1
    go mod init tmp
    go get "$1"
  )
}

pipx_install() { # target, spec, pip args
  if ! pipx list | grep -Fq "$1"; then
    info "Installing $1 using pipx..."
    pipx install "${3:-$1}" ${2:+--pip-args="$2"}
  fi
}
