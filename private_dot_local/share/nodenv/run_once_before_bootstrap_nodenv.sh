#!/bin/sh -e

if [ "$(basename "$PWD")" != 'nodenv' ]; then
  echo "Bootstrapping nodenv..."
  git clone https://github.com/nodenv/nodenv
  git clone https://github.com/nodenv/node-build nodenv/plugins/node-build
  git clone https://github.com/nodenv/nodenv-aliases nodenv/plugins/nodenv-aliases
  git clone https://github.com/momo-lab/xxenv-latest nodenv/plugins/xxenv-latest
  echo "Building native extensions..."
  nodenv/src/configure
  make -C nodenv/src
fi

# vi: ft=sh
