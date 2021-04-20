#!/bin/sh

if command -v chezmoi >/dev/null; then
  chezmoi completion fish
fi
