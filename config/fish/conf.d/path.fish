if not set -qU fish_initialized
  # personal
  set -U fish_user_paths \
    # rust
    "$CARGO_HOME/bin" \
    # ruby
    "$RBENV_ROOT/shims" "$RBENV_ROOT/bin" \
    # python
    "$PIPX_BIN_DIR" "$PYENV_ROOT/shims" "$PYENV_ROOT/bin" \
    # nodejs
    "$NODENV_ROOT/shims" "$NODENV_ROOT/bin" \
    # golang
    "$GOPATH/bin" "$GOENV_ROOT/shims" "$GOENV_ROOT/bin" \
    # dotfiles
    "$HOME/.local/bin"

  # ccache
  for path in \
    # macos
    /usr/local/opt/ccache/libexec \
    # bsd
    /usr/local/libexec/ccache \
    # linux
    /usr/lib/ccache

    if test -d "$path"
      set -U fish_user_paths $fish_user_paths $path
      break
    end
  end
end
