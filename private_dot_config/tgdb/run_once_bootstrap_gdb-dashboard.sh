#!/bin/sh -e

if [ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/gdb-dashboard" ]; then
  echo "Bootstrapping gdb-dashboard..."
  git clone https://github.com/cyrus-and/gdb-dashboard "${XDG_DATA_HOME:-$HOME/.local/share}/gdb-dashboard"
fi

# vi: ft=sh
