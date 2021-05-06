status is-login; or test $SHLVL -eq 1; or exit

#
# (man)path
#

# ccache {linux, {bsd, macos}}
path_prepend PATH /usr/{lib/ccache/bin,local/{libexec/ccache,opt/ccache/libexec}}

# dotnet
path_prepend PATH $DOTNET_TOOL_PATH $DOTNET_ROOT
# golang
path_prepend PATH $GOBIN $GOENV_ROOT/{shims,bin}
# nodejs
path_prepend PATH $NODENV_ROOT/{shims,bin}
# python
path_prepend PATH $PIPX_BIN_DIR $POETRY_HOME/bin $PYENV_ROOT/{shims,bin}
# ruby
path_prepend PATH $RBENV_ROOT/{shims,bin}
# rust
path_prepend PATH $CARGO_HOME/bin
# dotfiles/local
path_prepend PATH $HOME/.local/bin

#
# manpath
#

# base manpath
set -q MANPATH; or set -x MANPATH ''
# nodejs
if test -e $NODENV_ROOT/version
  set -q NODENV_VERSION; or read -l NODENV_VERSION < $NODENV_ROOT/version
  path_prepend MANPATH $NODENV_ROOT/versions/$NODENV_VERSION/share/man
end
# python
if test -e $PYENV_ROOT/version
  set -q PYENV_VERSION; or read -l PYENV_VERSION < $PYENV_ROOT/version
  path_prepend MANPATH $PYENV_ROOT/versions/$PYENV_VERSION/share/man
end
# ruby
if test -e $RBENV_ROOT/VERSION
  set -q RBENV_VERSION; or read -l RBENV_VERSION < $RBENV_ROOT/version
  path_prepend MANPATH $RBENV_ROOT/versions/$RBENV_VERSION/share/man
end
# rust
if not set -q RUSTUP_TOOLCHAIN
  test -e $RUSTUP_HOME/settings.toml
  and set -l RUSTUP_TOOLCHAIN (string match -r 'default_toolchain = "(.*)"' < $RUSTUP_HOME/settings.toml)[2]
  or set -l RUSTUP_TOOLCHAIN stable
end
path_prepend MANPATH $RUSTUP_HOME/toolchains/$RUSTUP_TOOLCHAIN/{,share/}man
# dotfiles/local
path_prepend MANPATH $HOME/.local/share/man


