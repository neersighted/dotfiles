# shellcheck shell=sh

support_subsection "Golang"

if [ -z "$GOBIN" ]; then
  export GOBIN="$XDG_DATA_HOME/go/bin"
fi
if [ -z "$GOENV_GOPATH_PREFIX" ]; then
  export GOENV_GOPATH_PREFIX="$XDG_DATA_HOME/go"
fi
if [ -z "$GOENV_ROOT" ]; then
  export GOENV_ROOT="$XDG_DATA_HOME/goenv"
fi
export GOENV_VERSION=
export PATH="$GOBIN:$GOENV_ROOT/bin:$PATH"

git_sync https://github.com/syndbg/goenv "$GOENV_ROOT"

(
  cd "$GOENV_ROOT" || exit 1
  src/configure
  make -C src
)

eval "$(goenv init -)"

GOLANG_VERSION=$(goenv install -l | selectversion)
if ! goenv versions | grep -Fq "$GOLANG_VERSION"; then
  info "Installing Golang $GOLANG_VERSION..."
  goenv install -s "$GOLANG_VERSION"
  info "Activating Golang $GOLANG_VERSION..."
  goenv global "$GOLANG_VERSION"
fi
