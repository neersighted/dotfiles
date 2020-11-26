#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Python"

important "Updating pyenv..."
git_sync https://github.com/pyenv/pyenv "$PYENV_ROOT"
git_sync https://github.com/pyenv/pyenv-virtualenv "$PYENV_ROOT/plugins/pyenv-virtualenv"
xenv_ext pyenv "$PYENV_ROOT"

PYTHON_VERSION=$(pyenv install -l | selectversion)
if ! pyenv versions --bare | grep -Fxq "$PYTHON_VERSION"; then
  important "Installing Python $PYTHON_VERSION..."
  pyenv install -s "$PYTHON_VERSION"
  important "Activating Python $PYTHON_VERSION..."
  pyenv global "$PYTHON_VERSION"
fi

if [ -x "$POETRY_HOME/bin/poetry" ]; then
  important "Updating Poetry..."
  poetry self update
else
  important "Installing Poetry..."
  curl -sS https://raw.githubusercontent.com/python-poetry/poetry/develop/get-poetry.py | python - --no-modify-path
fi

if ! pyvenv_version pipx "$(pyenv version-name)"; then
  important "Creating pipx virtual environment for Python $(pyenv version-name)..."
  pyenv uninstall -f pipx
  pyenv virtualenv pipx
  PYENV_VERSION=pipx python -m pip install -U pip setuptools pipx
  important "Reinstalling pipx apps..."
  pipx reinstall-all
else
  important "Updating pipx apps..."
  pipx upgrade-all
fi

important "Updating Python packages..."
for python in $(pyenv versions --bare --skip-aliases); do
  OLDIFS=$IFS
  IFS="$(printf '%b_' '\t\n')"
  IFS="${IFS%_}"
  for spec in $(PYENV_VERSION=$python python -m pip list --outdated --format=json | jq -r '.[] | "\(.name) from \(.version) to \(.latest_version)"'); do
    info "Updating $spec (Python $python)..."
    PYENV_VERSION=$python python -m pip install -U "${spec%% *}"
  done
  IFS=$OLDIFS
done

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
