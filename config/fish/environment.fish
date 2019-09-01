# locale
if not set -q LANG; or test $LANG = 'C.UTF-8'
  set -x LANG en_US.UTF-8
end

# tmpdir
if not set -q TMPDIR
  set -x TMPDIR /tmp
end

# xdg directories
if not set -q XDG_CONFIG_HOME
  set -x XDG_CONFIG_HOME $HOME/.config
end
if not set -q XDG_DATA_HOME
  set -x XDG_DATA_HOME $HOME/.local/share
end
if not set -q XDG_CACHE_HOME
  set -x XDG_CACHE_HOME $HOME/.cache
end
if not set -q XDG_RUNTIME_DIR
  set -x XDG_RUNTIME_DIR $TMPDIR
end

# tmux
set -x TMUX_TMPDIR $XDG_RUNTIME_DIR

# wsl
if wsl?
  set -x DISPLAY ':0'
  set -x SHELL (command -v fish)
  set -x BROWSER 'wslview'
  set -g umask 0022 # wsl current does not set umask
end
