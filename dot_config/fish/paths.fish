status is-login; or exit

# default manpath
set -q MANPATH; or set -x MANPATH ''

# snap
path_prepend PATH /snap/bin
# ccache {linux, {bsd, macos}}
path_prepend PATH /usr/{lib/ccache/bin,local/{libexec/ccache,opt/ccache/libexec}}

# golang
path_prepend PATH $GOBIN $GOENV_ROOT/{shims,bin}
# nodejs
path_prepend PATH $NODENV_ROOT/{shims,bin}
set -q NODENV_VERSION; or read -l NODENV_VERSION < $NODENV_ROOT/version
path_prepend MANPATH $NODENV_ROOT/versions/$NODENV_VERSION/share/man
# python
path_prepend PATH $PIPX_BIN_DIR $PYENV_ROOT/{shims,bin}
set -q PYENV_VERSION; or read -l PYENV_VERSION < $PYENV_ROOT/version
path_prepend MANPATH $PYENV_ROOT/versions/$PYENV_VERSION/share/man
# ruby
path_prepend PATH $RBENV_ROOT/{shims,bin}
set -q RBENV_VERSION; or read -l RBENV_VERSION < $RBENV_ROOT/version
path_prepend MANPATH $RBENV_ROOT/versions/$RBENV_VERSION/share/man
# rust
path_prepend PATH $CARGO_HOME/bin
set -q RUSTUP_TOOLCHAIN; or set -l RUSTUP_TOOLCHAIN (string match -r 'default_toolchain = "(.*)"' < $RUSTUP_HOME/settings.toml)[2]
path_prepend MANPATH $RUSTUP_HOME/toolchains/$RUSTUP_TOOLCHAIN/{,share/}man
# dotfiles/local
path_prepend PATH $HOME/.local/bin
path_prepend MANPATH $HOME/.local/share/man
