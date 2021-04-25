#!/bin/sh

curl -sSfL https://git.io/chezmoi | sh -s -- -b "$HOME/.local/bin" init --apply --remove neersighted
