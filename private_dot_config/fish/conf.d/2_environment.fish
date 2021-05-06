status is-login; or test $SHLVL -eq 1; or exit

#
# base
#

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
  if mkdir -p "$TMPDIR/runtime" &>/dev/null
    set -x XDG_RUNTIME_DIR "$TMPDIR/runtime"
  else
    set -x XDG_RUNTIME_DIR $TMPDIR
  end
end

# wsl
if is_wsl
  set --path WSLENV $WSLENV
  wslenv -p APPDATA
  wslenv -p LOCALAPPDATA
  set -x BROWSER 'wslview'
  set -x COLORTERM 'truecolor'
end
if is_wsl1
  set umask 0022
  set -x DISPLAY ':0'
end
