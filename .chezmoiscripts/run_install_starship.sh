#!/bin/sh

export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}" 

if [ ! "$(command -v starship)" ] || [ "$(dirname "$(command -v starship)")" = "$XDG_BIN_HOME" ]; then
  echo "Updating Starship..."
  curl -fsSL https://starship.rs/install.sh | sh -s -- -b "$XDG_BIN_HOME" -y >/dev/null
fi
