# pick up functions.d paths
set -p fish_function_path $__fish_config_dir/functions.d/*

# only run the remaining for login/'root' shells
not status is-login; or test $SHLVL -ne 1; and exit

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
if not set -q XDG_BIN_HOME
  set -x XDG_BIN_HOME $HOME/.local/bin
end
if not set -q XDG_CACHE_HOME
  set -x XDG_CACHE_HOME $HOME/.cache
end
if not set -q XDG_RUNTIME_DIR
  set -x XDG_RUNTIME_DIR "/run/user/"(id -u)
  if not mkdir -p -m 0700 "$XDG_RUNTIME_DIR" &>/dev/null
    set -x XDG_RUNTIME_DIR $TMPDIR
  end
end

# wsl
if is_wsl
  wslenv -p APPDATA
  wslenv -p LOCALAPPDATA
  wslenv -p USERPROFILE
  wslenv TERMINAL_EMULATOR

  set -x BROWSER 'wslview'

  if is_wsl1
    set umask 0022
    set -x DISPLAY ':0'
  end
end

# macos
if is_macos
  test -x /usr/local/bin/brew; and /usr/local/bin/brew shellenv | source
  test -x /opt/homebrew/bin/brew; and /opt/homebrew/bin/brew shellenv | source
end

#
# toolchains
#

# golang
set -x GOENV_ROOT $XDG_DATA_HOME/goenv
set -x GOENV_GOPATH_PREFIX $XDG_DATA_HOME/go
set -x GOBIN $XDG_DATA_HOME/go/bin
set -x GO111MODULE on

# haskell
set -x STACK_ROOT $XDG_DATA_HOME/stack

# node.js
set -x NODENV_ROOT $XDG_DATA_HOME/nodenv
set -x NODE_REPL_HISTORY $XDG_DATA_HOME/node/repl_history
set -x NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -x NPM_CONFIG_PREFIX $HOME/.local
set -x NPM_CONFIG_STORE_DIR $XDG_CACHE_HOME/pnpm
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc

# python
set -x PYENV_ROOT $XDG_DATA_HOME/pyenv
set -x PIPX_HOME $XDG_DATA_HOME/pipx
set -x PYLINTHOME $XDG_CACHE_HOME/pylint
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py

# ruby
set -x RBENV_ROOT $XDG_DATA_HOME/rbenv
set -x IRBRC $XDG_CONFIG_HOME/irb/irbrc
set -x GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
set -x BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
set -x BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -x BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle

# rust
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x CARGO_HOME $XDG_DATA_HOME/cargo

#
# tools
#

# aws
set -x AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config
set -x AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials

# bash
set -x HISTFILE $XDG_DATA_HOME/bash/history

# ccache
set -x CCACHE_DIR $XDG_CACHE_HOME/ccache

# docker
set -x DOCKER_BUILDKIT 1

# homebrew
is_macos; and set -x HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/brew/Brewfile

# less
set -x LESSHISTFILE $XDG_DATA_HOME/less/history

# lsof
set -x LSOFDEVCACHE $XDG_CACHE_HOME/lsof

# mysql
set -x MYSQL_HISTFILE $XDG_DATA_HOME/mysql/history

# (n)vim
set -x VIM_CONFIG_PATH $XDG_CONFIG_HOME/nvim

# redis
set -x REDISCLI_HISTFILE $XDG_DATA_HOME/rediscli/history

# ripgrep
set -x RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/config

# shiv
set -x SHIV_ROOT $XDG_CACHE_HOME/shiv

# tmux
set -x TMUX_TMPDIR $XDG_RUNTIME_DIR

# wget
set -x WGETRC $XDG_CONFIG_HOME/wget/wgetrc

# vagrant
set -x VAGRANT_HOME $XDG_DATA_HOME/vagrant

#
# (MAN)PATH
#

# brewed utilities
is_macos; and path_prepend PATH (brew --prefix)/opt/{curl,sqlite,python/libexec}/bin
# ccache {linux, bsd}, macos
is_macos; and path_prepend PATH (brew --prefix)/opt/ccache/libexec
          or path_prepend PATH /usr/{lib/ccache/bin,local/libexec/ccache} 
# golang
path_prepend PATH $GOBIN $GOENV_ROOT/{shims,bin}
# nodejs
path_prepend PATH $NODENV_ROOT/{shims,bin}
# python
path_prepend PATH $PYENV_ROOT/{shims,bin}
# ruby
path_prepend PATH $RBENV_ROOT/{shims,bin}
# rust
path_prepend PATH $CARGO_HOME/bin
# dotfiles/local
path_prepend PATH $HOME/.local/bin $XDG_BIN_HOME

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
if test -e $RBENV_ROOT/version
  set -q RBENV_VERSION; or read -l RBENV_VERSION < $RBENV_ROOT/version
  path_prepend MANPATH $RBENV_ROOT/versions/$RBENV_VERSION/share/man
end
# rust
if test -e $RUSTUP_HOME/toolchains
  set -l rustup_toolchain stable
  if set -q RUSTUP_TOOLCHAIN
    set rustup_toolchain $RUSTUP_TOOLCHAIN
  else if test -e $RUSTUP_HOME/settings.toml
    set rustup_toolchain (string match -r 'default_toolchain = "(.*)"' < $RUSTUP_HOME/settings.toml)[2]
  end
  path_prepend MANPATH $RUSTUP_HOME/toolchains/$rustup_toolchain*/{,share/}man
end
# dotfiles/local
path_prepend MANPATH $HOME/.local/share/man
