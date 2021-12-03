#!/bin/sh -e

if [ "$(basename "$PWD")" != 'rbenv' ]; then
  echo "Bootstrapping rbenv..."
  git clone https://github.com/rbenv/rbenv
  git clone https://github.com/rbenv/ruby-build rbenv/plugins/ruby-build
  git clone https://github.com/rbenv/rbenv-default-gems rbenv/plugins/rbenv-default-gems
  git clone https://github.com/momo-lab/xxenv-latest rbenv/plugins/xxenv-latest

  echo "Building native extensions..."
  rbenv/src/configure
  make -C rbenv/src
fi

# vi: ft=sh
