#!/bin/sh

if [ ! -d "${XDG_DATA_HOME:-~/.local/share}/gdb-dashboard" ]; then
  git clone https://github.com/cyrus-and/gdb-dashboard "${XDG_DATA_HOME:-~/.local/share}/gdb-dashboard"
fi

# vi: ft=sh
