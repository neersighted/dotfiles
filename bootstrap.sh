#!/bin/sh

DOTFILES=${DOTFILES:-~/.local/share/chezmoi}
REPO=${REPO:-neersighted}

CHEZMOI=chezmoi
if ! command -v chezmoi >/dev/null; then
  echo "Bootstrapping chezmoi..."
  curl -sSfL https://git.io/chezmoi | sed 's/openssl -dst //' | sh -s -- -b "$HOME/.local/bin"
  CHEZMOI="$HOME/.local/bin/chezmoi"
fi

echo "Applying dotfiles with chezmoi..."
if [ -d "$DOTFILES" ]; then
  $CHEZMOI apply --remove
else
  $CHEZMOI init --apply "$REPO"
fi
