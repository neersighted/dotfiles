#!/bin/sh

if ! command -v fetch >/dev/null; then
  fetch() {
    curl -sSfL "$@"
  }
fi

fetch -o - https://git.io/chezmoi | sh -s -- -b "$HOME/.local/bin" -- init --apply --remove neersighted
