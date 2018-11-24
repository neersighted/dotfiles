# first login (tmux creates login shells)
if status --is-login; and not set -qg TMUX
  # PATH

  # snap
  path_prepend /snap/bin
  # ccache {linux, {bsd, macos}}
  path_prepend /usr/{lib/ccache,local/{libexec/ccache,opt/ccache/libexec}}

  # golang
  path_prepend $GOPATH/bin $GOENV_ROOT/{shims,bin}
  # nodejs
  path_prepend $NODENV_ROOT/{shims,bin}
  # python
  path_prepend $PYENV_ROOT/{shims,bin}
  path_prepend $PYENV_ROOT/plugins/pyenv-virtualenv/shims $PIPX_BIN_DIR
  # ruby
  path_prepend $RBENV_ROOT/{shims,bin}
  # rust
  path_prepend $CARGO_HOME/bin
  # dotfiles/local
  path_prepend $HOME/.local/bin

  # MANPATH

  # base manpath
  if not set -qg MANPATH; and command -sq manpath
    set -gx MANPATH (string split ':' (manpath))
  end

  # additional manpages
  if test -n "$MANPATH"
    for manpath in \
      $NODENV_ROOT/versions/*/share/man \
      $PYENV_ROOT/versions/*/share/man \
      $PIPX_HOME/*/share/man \
      $RBENV_ROOT/versions/*/share/man \
      $RUSTUP_HOME/toolchains/*/share/man

      set -gx MANPATH $manpath $MANPATH
    end
  end
end
