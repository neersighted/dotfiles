status is-login; or test $SHLVL -eq 1; or exit

function def -a var val
  set -qUx $var; or set -gx $var $val
end

#
# base
#

# xdg directories
if not set -q XDG_CONFIG_HOME
  set -x XDG_CONFIG_HOME $HOME/.config
end
if not set -q XDG_DATA_HOME
  set -x XDG_DATA_HOME $HOME/.local/share
end
if not set -q XDG_CACHE_HOME
  set -x XDG_CACHE_HOME $HOME/.cache
end
if not set -q XDG_RUNTIME_DIR
  if test -n "$TMPDIR"
    set -x XDG_RUNTIME_DIR $TMPDIR
  else
    set -x XDG_RUNTIME_DIR /tmp
  end
end

# wsl
if is_wsl
  set --path WSLENV $WSLENV
  wslenv -p APPDATA
  wslenv -p LOCALAPPDATA
  set -x BROWSER 'wslview'
  set -x COLORTERM 'truecolor'
end
if is_wsl1
  set umask 0022
  set -x DISPLAY ':0'
end

#
# core
#

# editor
def EDITOR nvim
def VISUAL $EDITOR

# pager
def PAGER less

#
# toolchains
#

# golang
def GOENV_ROOT $XDG_DATA_HOME/goenv
def GOENV_GOPATH_PREFIX $XDG_DATA_HOME/go
def GOBIN $XDG_DATA_HOME/go/bin

# haskell
def STACK_ROOT $XDG_DATA_HOME/stack

# node.js
def NODENV_ROOT $XDG_DATA_HOME/nodenv
def NODE_REPL_HISTORY $XDG_DATA_HOME/node/repl_history
def NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
def NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
def NPM_CONFIG_STORE_DIR $XDG_CACHE_HOME/pnpm

# python
def PYENV_ROOT $XDG_DATA_HOME/pyenv
def PIPX_HOME $XDG_DATA_HOME/pipx
def PIPX_BIN_DIR $XDG_DATA_HOME/pipx/bin
def POETRY_HOME $XDG_DATA_HOME/poetry
def PYLINTHOME $XDG_CACHE_HOME/pylint
def PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py

# ruby
def RBENV_ROOT $XDG_DATA_HOME/rbenv
def IRBRC $XDG_CONFIG_HOME/irb/irbrc
def GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
def BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
def BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
def BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle

# rust
def RUSTUP_HOME $XDG_DATA_HOME/rustup
def CARGO_HOME $XDG_DATA_HOME/cargo

#
# tools
#

# aws
def AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config
def AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials

# bash
def HISTFILE $XDG_DATA_HOME/bash/history

# bat
def BAT_THEME Nord
def BAT_PAGER 'less --quit-if-one-screen --no-init'

# ccache
def CCACHE_DIR $XDG_CACHE_HOME/ccache

# homebrew
def HOMEBREW_AUTO_UPDATE_SECS 86400

# gnupg
def GNUPGHOME $HOME/.gnupg

# httpie
def HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie

# less
def LESS '--mouse --RAW-CONTROL-CHARS --tabs=2'
def LESSHISTFILE $XDG_DATA_HOME/less/history

# libvirt
def LIBVIRT_DEFAULT_URI qemu:///system

# lsof
def LSOFDEVCACHE $XDG_CACHE_HOME/lsof

# mysql
def MYSQL_HISTFILE $XDG_DATA_HOME/mysql/history

# (n)vim
def VIM_CONFIG_PATH $XDG_CONFIG_HOME/nvim

# redis
def REDISCLI_HISTFILE $XDG_DATA_HOME/rediscli/history

# ripgrep
def RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/config

# tmux
set -x TMUX_TMPDIR $XDG_RUNTIME_DIR

# wget
def WGETRC $XDG_CONFIG_HOME/wget/wgetrc

# vagrant
def VAGRANT_HOME $XDG_DATA_HOME/vagrant
def VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1

# z
set -qU Z_OWNER; or set -U Z_OWNER $USER

#
# fzf
#

# core
def FZF_BASE_OPTS '--ansi --no-bold --cycle'
def FZF_DEFAULT_COMMAND 'fd --color always --type file --type directory --follow --hidden .'

# plugin (ui)
test "$FZF_LEGACY_KEYBINDINGS" = 0; or set -U FZF_LEGACY_KEYBINDINGS 0
test "$FZF_TMUX" = 1; or set -U FZF_TMUX 1

# plugin (commands)
def FZF_CD_COMMAND 'fd --color always --type directory --follow . $dir'
def FZF_CD_WITH_HIDDEN_COMMAND $FZF_CD_COMMAND' --hidden'
def FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND' $dir'
def FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND' $dir'

# plguin (options)
def FZF_CD_OPTS "--preview='peek {}'"
def FZF_FIND_FILE_OPTS "--preview='peek {}'"
def FZF_OPEN_OPTS "--preview='peek {}'"

#
# (man)path
#

# ccache {linux, {bsd, macos}}
path_prepend PATH /usr/{lib/ccache/bin,local/{libexec/ccache,opt/ccache/libexec}}

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

functions -e def
