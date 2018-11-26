if status --is-login
  # snap
  path_prepend /snap/bin
  # ccache {linux, {bsd, macos}}
  path_prepend /usr/{lib/ccache,local/{libexec/ccache,opt/ccache/libexec}}

  # golang
  path_prepend $GOPATH/bin $GOENV_ROOT/{shims,bin}
  # nodejs
  path_prepend $NODENV_ROOT/{shims,bin}
  # python
  path_prepend $PIPX_BIN_DIR $PYENV_ROOT/{shims,bin}
  # ruby
  path_prepend $RBENV_ROOT/{shims,bin}
  # rust
  path_prepend $CARGO_HOME/bin
  # dotfiles/local
  path_prepend $HOME/.local/bin

  # MANPATH
  if not set -q MANPATH
    # search default manpath
    set -x MANPATH ''

    # additional manpages
    for manpath in \
      $NODENV_ROOT/versions/*/share/man \
      $PYENV_ROOT/versions/*/share/man \
      $PIPX_HOME/*/share/man \
      $RBENV_ROOT/versions/*/share/man \
      $RUSTUP_HOME/toolchains/*/share/man

      set MANPATH $manpath $MANPATH
    end
  end
end
