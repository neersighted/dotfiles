#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Python"

important "Updating pyenv..."
git_sync https://github.com/pyenv/pyenv "$PYENV_ROOT"
git_sync https://github.com/pyenv/pyenv-virtualenv "$PYENV_ROOT/plugins/pyenv-virtualenv"

if ! $MAKE -C "$PYENV_ROOT/src" -q; then
  info "Building pyenv native extensions..."
  (
    cd "$PYENV_ROOT"
    ./src/configure
  )
  $MAKE -C "$PYENV_ROOT/src"
fi

PYTHON_VERSION=$(pyenv install -l | selectversion)
if ! pyenv versions --bare | grep -Fxq "$PYTHON_VERSION"; then
  important "Installing Python $PYTHON_VERSION..."
  pyenv install -s "$PYTHON_VERSION"
  important "Activating Python $PYTHON_VERSION..."
  pyenv global "$PYTHON_VERSION"
fi

if [ ! -d "$PIPX_HOME/venvs/pipx" ]; then
  important "Installing pipx..."
  pip install pipx-in-pipx
else
  glob_python=$(realpath "$(pyenv which python)")
  pipx_python=$(realpath "$PIPX_HOME/venvs/pipx/bin/python")
  if [ "$pipx_python" != "$glob_python" ]; then
    important "Reinstalling pipx with Python $PYTHON_VERSION..."
    pipx uninstall pipx
    pip install pipx-in-pipx
  fi
fi

if [ ! -x "$POETRY_HOME/bin/poetry" ]; then
  important "Installing Poetry..."
  curl -sS https://raw.githubusercontent.com/python-poetry/poetry/develop/get-poetry.py | python - --no-modify-path
fi

important "Updating Python packages..."
for python in $(pyenv versions --bare --skip-aliases); do
  OLDIFS=$IFS
  IFS="$(printf '%b_' '\t\n')"
  IFS="${IFS%_}"
  for spec in $(PYENV_VERSION=$python pip list --outdated --format=json | jq -r '.[] | "\(.name) from \(.version) to \(.latest_version)"'); do
    info "Updating $spec (Python $python)..."
    PYENV_VERSION=$python python -m pip install -U "${spec%% *}"
  done
  IFS=$OLDIFS
done
pipx upgrade-all
poetry self update || true # FIXME: hack til upstream fixes $POETRY_HOME support

pipx_install "argcomplete"
pipx_install "black"
pipx_install "dephell" "dephell[full]"
pipx_install "flake8"
pipx_install "mypy"
pipx_install "pip-run"
pipx_install "pip-tools"
pipx_install "pylint"
pipx_install "python-language-server" "python-language-server[all]"
pipx_install "twine"

# vi: ft=sh