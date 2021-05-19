#!/bin/sh -e

if [ "$(basename "$PWD")" != 'pyenv' ]; then
  echo "Bootstrapping pyenv..."
  git clone https://github.com/pyenv/pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv pyenv/plugins/pyenv-virtualenv
  echo "Building native extensions..."
  pyenv/src/configure
  make -C pyenv/src
fi

# vi: ft=sh
