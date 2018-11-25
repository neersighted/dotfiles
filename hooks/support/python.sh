# shellcheck shell=sh

support_subsection "Python"

if [ -z "$PIPX_HOME" ]; then
  export PIPX_HOME="$XDG_DATA_HOME/pipx/venvs"
fi
if [ -z "$PIPX_BIN_DIR" ]; then
  export PIPX_BIN_DIR="$XDG_DATA_HOME/pipx/bin"
fi
if [ -z "$PYENV_ROOT" ]; then
  export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
fi
export PYENV_VERSION=
export PATH="$PIPX_BIN_DIR:$PYENV_ROOT/bin:$PATH"

info "Syncing pyenv..."
git_sync https://github.com/pyenv/pyenv "$PYENV_ROOT"
git_sync https://github.com/pyenv/pyenv-virtualenv "$PYENV_ROOT/plugins/pyenv-virtualenv"

eval "$(pyenv init -)"

PYENV_INSTALLED=$(pyenv versions --skip-aliases --bare)
PYTHON_VERSIONS=$(pyenv install -l)
PYTHON2_VERSION=$(echo "$PYTHON_VERSIONS" | selectversion 2)
PYTHON3_VERSION=$(echo "$PYTHON_VERSIONS" | selectversion 3)

if ! echo "$PYENV_INSTALLED" | grep -Fq "$PYTHON2_VERSION"; then
  info "Installing Python $PYTHON2_VERSION..."
  pyenv install -s "$PYTHON2_VERSION"
fi
if ! echo "$PYENV_INSTALLED" | grep -Fq "$PYTHON3_VERSION"; then
  info "Installing Python $PYTHON3_VERSION..."
  pyenv install -s "$PYTHON3_VERSION"
fi

if ! pyenv global | grep -Fq "$PYTHON2_VERSION" ||
   ! pyenv global | grep -Fq "$PYTHON3_VERSION"; then
  info "Activating Python $PYTHON3_VERSION and $PYTHON2_VERSION..."
  pyenv global "$PYTHON3_VERSION" "$PYTHON2_VERSION"
fi

PYENV_INSTALLED=$(pyenv versions --skip-aliases --bare)

for python in $PYENV_INSTALLED;  do
  for target in $(PYENV_VERSION=$python pip list --outdated --format=freeze | awk -F== '{print $1}'); do
    info "Updating $target ($python)..."
    PYENV_VERSION=$python pip install -U "$target"
  done
done

if ! command -v pipx >/dev/null; then
  info "Installing pipx..."
  curl -L https://git.io/get-pipx | python3 - --no-modify-path
else
  info "Updating pipx packages..."
  pipx upgrade-all
fi
