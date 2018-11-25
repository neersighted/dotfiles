# shellcheck shell=sh

support_subsection "Golang"

if [ -z "$GOPATH" ]; then
  export GOPATH="$XDG_DATA_HOME/go"
fi
if [ -z "$GOENV_ROOT" ]; then
  export GOENV_ROOT="$XDG_DATA_HOME/goenv"
fi
export GOENV_VERSION=
export PATH="$GOENV_ROOT/bin:$PATH"

info "Syncing goenv..."
git_sync https://github.com/syndbg/goenv "$GOENV_ROOT"

eval "$(goenv init -)"

GOLANG_VERSION=$(goenv install -l | selectversion)
if ! goenv versions | grep -Fq "$GOLANG_VERSION"; then
  info "Installing Golang $GOLANG_VERSION..."
  goenv install -s "$GOLANG_VERSION"
  info "Activating Golang $GOLANG_VERSION..."
  goenv global "$GOLANG_VERSION"
fi
