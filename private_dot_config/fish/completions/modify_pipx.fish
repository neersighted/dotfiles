#!/bin/sh

if [ -d "$PYENV_ROOT/versions/pipx" ]; then
  "$PYENV_ROOT"/versions/pipx/bin/register-python-argcomplete --shell fish pipx
fi
