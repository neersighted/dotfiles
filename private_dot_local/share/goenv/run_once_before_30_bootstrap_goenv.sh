#!/bin/sh -e

if [ "$(basename "$PWD")" != 'goenv' ]; then
  echo "Bootstrapping goenv..."
  git clone https://github.com/syndbg/goenv
  echo "Building native extensions..."
  goenv/src/configure
  make -C goenv/src
fi

# vi: ft=sh
