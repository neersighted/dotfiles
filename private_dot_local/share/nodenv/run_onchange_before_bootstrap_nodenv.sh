#!/bin/sh -e

if [ "$(basename "$PWD")" != 'nodenv' ]; then
  echo "Bootstrapping nodenv..."
  git clone https://github.com/nodenv/nodenv
  git clone https://github.com/nodenv/node-build nodenv/plugins/node-build
  git clone https://github.com/nodenv/nodenv-default-packages nodenv/plugins/nodenv-default-packages
  git clone https://github.com/nodenv/nodenv-package-rehash nodenv/plugins/nodenv-package-rehash
  echo "Building native extensions..."
  nodenv/src/configure
  make -C nodenv/src
fi

# vi: ft=sh
