# snap
path_prepend /snap/bin
# ccache {linux, {bsd, macos}}
path_prepend /usr/{lib/ccache/bin,local/{libexec/ccache,opt/ccache/libexec}}

# golang
path_prepend $GOBIN $GOENV_ROOT/{shims,bin}
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

  # nodenv
  set -q NODENV_VERSION; or read -l NODENV_VERSION < $NODENV_ROOT/version
  set -p MANPATH $NODENV_ROOT/versions/$NODENV_VERSION/share/man

  # pyenv
  set -q PYENV_VERSION; or read -l PYENV_VERSION < $PYENV_ROOT/version
  set -p MANPATH $PYENV_ROOT/versions/$PYENV_VERSION/share/man

  # rbenv
  set -q RBENV_VERSION; or read -l RBENV_VERSION < $RBENV_ROOT/version
  set -p MANPATH $RBENV_ROOT/versions/$RBENV_VERSION/share/man

  # rustup
  set -q RUSTUP_TOOLCHAIN; or set -l RUSTUP_TOOLCHAIN (string match -r 'default_toolchain = "(.*)"' < $RUSTUP_HOME/settings.toml)[2]
  set -p MANPATH $RUSTUP_HOME/toolchains/$RUSTUP_TOOLCHAIN/share/man

  # user-created
  set -p MANPATH $XDG_DATA_HOME/man
end
