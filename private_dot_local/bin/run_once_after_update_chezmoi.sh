#!/bin/sh -e

if [ "$(dirname "$(command -v chezmoi)")" = "$(pwd)" ]; then
  if [ "$(which -a chezmoi | wc -l)" -gt 1 ]; then
    echo "Switching to system-managed chezmoi..."
    rm ./chezmoi
  else
    echo "Self-updating bootstrapped chezmoi..."
    ./chezmoi upgrade
  fi
fi
