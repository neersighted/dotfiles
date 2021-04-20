#!/bin/sh

if [ -d "$PYENV_ROOT/versions/pipx" ]; then
  PYENV_VERSION=pipx register-python-argcomplete --shell fish pipx
fi
