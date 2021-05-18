#!/bin/sh

for term in alacritty-direct iterm2 tmux-256color; do
  if ! /usr/bin/infocmp $term >/dev/null 2>&1; then
    echo "Backporting brewed $term terminfo..."

    terminfo=$(mktemp)
    trap 'rm $terminfo' EXIT

    /usr/local/opt/ncurses/bin/infocmp -x $term \
      | sed 's/pairs#0x10000/pairs#0x1000/' > "$terminfo"
    /usr/bin/tic -x "$terminfo"
  fi
done
