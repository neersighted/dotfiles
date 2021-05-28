#!/bin/sh -e

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="${XDG_BIN_HOME:-$HOME/.local/bin}"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    curl -sSfL https://git.io/chezmoi | sh -s -- -b "$bin_dir"
  elif [ "$(command -v fetch)" ]; then
    fetch -o - https://git.io/chezmoi | sh -s -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    wget -qO- https://git.io/chezmoi | sh -s -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl, fetch, or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
if [ -e "$script_dir/.git" ]; then
  source_dir="$script_dir" # re-use a cloned source dir if it exists
fi

stdin='/dev/null'
if [ "$(ps otty= $$)" != '?' ]; then
  stdin='/dev/tty' # connect chezmoi to the tty when available
fi

$chezmoi init --apply ${source_dir:+--source="$source_dir"} "$@" neersighted <$stdin

echo "Bootstrap complete! Restart your shell and run 'chezmoi apply' for stage 2!"
