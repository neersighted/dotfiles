#!/bin/sh

if ! /usr/bin/infocmp tmux-256color >/dev/null 2>&1; then
  terminfo=$(mktemp)
  trap 'rm $terminfo' EXIT

  /usr/local/opt/ncurses/bin/infocmp -x tmux-256color \
    | sed 's/pairs#0x10000/pairs#0x1000/' > "$terminfo"
  /usr/bin/tic -x "$terminfo"
fi