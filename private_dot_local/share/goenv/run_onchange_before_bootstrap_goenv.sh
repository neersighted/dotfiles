#!/bin/sh -e

if [ "$(basename "$PWD")" != 'goenv' ]; then
  echo "Bootstrapping goenv..."
  git clone https://github.com/syndbg/goenv
  git clone https://github.com/momo-lab/xxenv-latest goenv/plugins/xxenv-latest

  echo "Building native extensions..."
  goenv/src/configure
  make -C goenv/src
fi
