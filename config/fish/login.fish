# shell init (environmental variables)
if status --is-login
  # load system profile (with bass)
  type -q bass
    and bass source /etc/profile

  # xdg (bsd compat)
  set -q XDG_VTNR; and type -q vidcontrol
    and set -x XDG_VTNR (vidcontrol -i active 2>/dev/null)

  # xdg
  set -q XDG_CONFIG_HOME
    or set -x XDG_CONFIG_HOME $HOME/.config
  set -q XDG_DATA_HOME
    or set -x XDG_DATA_HOME $HOME/.local/share
  set -q XDG_CACHE_HOME
    or set -x XDG_CACHE_HOME $HOME/.cache

  # golang
  set -q GOPATH
    or set -x GOPATH $HOME/.local/go

  # python
  set -q PIPX_BIN_DIR
    or set -x PIPX_BIN_DIR $HOME/.local/pipx/bin

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
  type -q systemctl
    and systemctl --user import-environment PATH 2>/dev/null

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
  test "$parent" = "mosh-server"
    and set -x MOSH 1

  # wsl detection
  string match -q -e "Microsoft" (uname -r)
    and set -x WSL 1

  # set shell
  type -q fish
    and set -x SHELL (command -v fish)
end

# vi:ft=fish:
