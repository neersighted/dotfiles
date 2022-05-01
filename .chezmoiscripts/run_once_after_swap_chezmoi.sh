#!/bin/sh -e

local_chezmoi="${XDG_BIN_HOME:-$HOME/.local/bin}/chezmoi"

if which -a chezmoi | grep -q "$local_chezmoi"; then
  echo "Switching to system-managed chezmoi..."
  rm -f "$local_chezmoi"
fi
