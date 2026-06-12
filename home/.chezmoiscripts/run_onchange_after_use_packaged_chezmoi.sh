#!/bin/sh -e
cd "${XDG_BIN_HOME:-$HOME/.local/bin}"
if [ -f "./chezmoi" ] && [ "$(which -a chezmoi | wc -l)" -gt 1 ]; then
  echo "Switching to system-managed chezmoi..."
  rm -f "./chezmoi"
fi
