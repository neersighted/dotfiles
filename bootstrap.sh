#!/bin/sh -e

# base
if [ -z "$LANG" ] || [ "$LANG" = C.UTF-8 ]; then
  export LANG="en_US.UTF-8"
fi
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

if [ ! "$(command -v fetch)" ]; then
  fetch() {
    curl -sSfL "$@"
  }
fi

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  fetch -o - https://git.io/chezmoi | sh -s -- -b "$bin_dir"
else
  chezmoi=chezmoi
fi

stdin='/dev/null'
if [ "$(ps otty= $$)" != '?' ]; then
  stdin='/dev/tty' # connect chezmoi to the tty when available
fi

exec $chezmoi init --apply --remove "$@" neersighted <$stdin

echo "Bootstrap complete! Restart your shell and run 'chezmoi apply' for stage 2!"
