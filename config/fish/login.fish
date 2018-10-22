# shell init (environmental variables)
if status --is-login
  # load system profile (with bass)
  if type -q bass
    bass source /etc/profile
  end

  # xdg (bsd compat)
  if not set -qx XDG_VTNR; and type -q vidcontrol
    set -x XDG_VTNR (vidcontrol -i active 2>/dev/null)
  end

  # xdg
  if not set -qx XDG_CONFIG_HOME
    set -x XDG_CONFIG_HOME $HOME/.config
  end
  if not set -qx XDG_DATA_HOME
    set -x XDG_DATA_HOME $HOME/.local/share
  end
  if not set -qx XDG_CACHE_HOME
    set -x XDG_CACHE_HOME $HOME/.cache
  end

  # golang
  if not set -qUx GOPATH
    set -x GOPATH $HOME/.local/share/go
  end

  # python
  if not set -qUx PIPX_BIN_DIR
    set -x PIPX_BIN_DIR $HOME/.local/pipx/bin
  end

  # ccache
  path_prepend /usr/local/opt/ccache/libexec # macos
  path_prepend /usr/local/libexec/ccache # bsd
  path_prepend /usr/lib/ccache/bin # linux

  # personal
  path_prepend $HOME/.local/bin # dotfiles
  path_prepend $HOME/.cargo/bin # rust
  path_prepend $HOME/.rbenv/shims $HOME/.rbenv/bin # ruby
  path_prepend $PIPX_BIN_DIR $HOME/.pyenv/shims $HOME/.pyenv/bin # python
  path_prepend $HOME/.nodenv/shims $HOME/.nodenv/bin # nodejs
  path_prepend $GOPATH/bin $HOME/.goenv/shims $HOME/.goenv/bin # golang

  # notify systemd of path
  if type -q systemctl
    systemctl --user import-environment PATH 2>/dev/null
  end

  # coreutils
  if type -q dircolors
    source (dircolors -c ~/.dircolors | psub)
  else if type -q gdircolors
    source (gdircolors -c ~/.dircolors | psub)
  end

  # less
  if type -q lesspipe
    source (env SHELL=csh lesspipe | psub)
  else if type -q lesspipe.sh
    source (env SHELL=csh lesspipe.sh | psub)
  end

  # mosh detection
  set parent (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]'))
  if test "$parent" = "mosh-server"
    set -x MOSH 1
  end

  # wsl detection
  if string match -q -e "Microsoft" (uname -r)
    set -x WSL 1
  end

  # set shell
  if type -q fish
    set -x SHELL (command -v fish)
  end
end

# vi:ft=fish:
