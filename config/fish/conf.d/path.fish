# first login (tmux creates login shells)
if status --is-login; and not set -qg TMUX
  # snap
  path_prepend /snap/bin
  # ccache {linux, {bsd, macos}}
  path_prepend /usr/{lib/ccache,local/{libexec/ccache,opt/ccache/libexec}}

  # golang
  path_prepend $GOPATH/bin $GOENV_ROOT/{shims,bin}
  # nodejs
  path_prepend $NODENV_ROOT/{shims,bin}
  # python
  path_prepend $PIPX_BIN_DIR $PYENV_ROOT/{plugins/pyenv-virtualenv/shims,shims,bin}
  # ruby
  path_prepend $RBENV_ROOT/{shims,bin}
  # rust
  path_prepend $CARGO_HOME/bin
  # dotfiles/local
  path_prepend $HOME/.local/bin
end
