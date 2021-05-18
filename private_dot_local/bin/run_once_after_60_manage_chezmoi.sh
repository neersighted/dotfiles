#!/bin/sh

if [ "$(dirname "$(command -v chezmoi)")" = "$(pwd)" ]; then
  if [ "$(which -a chezmoi | wc -l)" -gt 1 ]; then
    important "Switching to system-managed chezmoi..."
    rm ./chezmoi
  else
    important "Self-updating bootstrapped chezmoi..."
    ./chezmoi upgrade
  fi
fi
