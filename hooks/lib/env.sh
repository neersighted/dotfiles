# shellcheck shell=sh

if [ -z "$LANG" ] || [ "$LANG" = C.UTF-8 ]; then
  export LANG="en_US.UTF-8"
fi

if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

if [ -z "$CC" ]; then
  export CC=cc
fi
if [ -z "$CXX" ]; then
  export CCX=c++
fi
