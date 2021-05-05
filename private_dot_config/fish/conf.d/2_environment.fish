status is-login; or test $SHLVL -eq 1; or exit

function def -a var val
  set -qUx $var; or set -gx $var $val
end

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
if not set -q XDG_CACHE_HOME
  set -x XDG_CACHE_HOME $HOME/.cache
end
if not set -q XDG_RUNTIME_DIR
  if mkdir -p "$TMPDIR/runtime" &>/dev/null
    set -x XDG_RUNTIME_DIR "$TMPDIR/runtime"
  else
    set -x XDG_RUNTIME_DIR $TMPDIR
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

# dotnet
set -x DOTNET_ROOT $XDG_DATA_HOME/dotnet
set -x DOTNET_TOOL_PATH $DOTNET_ROOT/tools
set -x NUGET_PACKAGES $XDG_DATA_HOME/nuget

# golang
set -x GOENV_ROOT $XDG_DATA_HOME/goenv
set -x GOENV_GOPATH_PREFIX $XDG_DATA_HOME/go
set -x GOBIN $XDG_DATA_HOME/go/bin

# haskell
set -x STACK_ROOT $XDG_DATA_HOME/stack

# node.js
set -x NODENV_ROOT $XDG_DATA_HOME/nodenv
set -x NODE_REPL_HISTORY $XDG_DATA_HOME/node/repl_history
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -x NPM_CONFIG_STORE_DIR $XDG_CACHE_HOME/pnpm

# python
set -x PYENV_ROOT $XDG_DATA_HOME/pyenv
set -x PIPX_HOME $XDG_DATA_HOME/pipx
set -x PIPX_BIN_DIR $XDG_DATA_HOME/pipx/bin
set -x POETRY_HOME $XDG_DATA_HOME/pypoetry
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

# bat
set -x BAT_THEME Nord
set -x BAT_PAGER 'less --quit-if-one-screen --no-init'

# bd
set BD_OPT 'insensitive'

# ccache
set -x CCACHE_DIR $XDG_CACHE_HOME/ccache

# homebrew
set -x HOMEBREW_AUTO_UPDATE_SECS 86400

# gnupg
set -x GNUPGHOME $HOME/.gnupg

# httpie
set -x HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie

# less
set -x LESS '--mouse --RAW-CONTROL-CHARS --tabs=2'
set -x LESSHISTFILE $XDG_DATA_HOME/less/history

# libvirt
def LIBVIRT_DEFAULT_URI qemu:///system

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

# tmux
set -x TMUX_TMPDIR $XDG_RUNTIME_DIR

# wget
set -x WGETRC $XDG_CONFIG_HOME/wget/wgetrc

# vagrant
set -x VAGRANT_HOME $XDG_DATA_HOME/vagrant
set -x VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1

# z
set -qU Z_OWNER; or set -U Z_OWNER $USER

#
# fzf
#

# core
set FZF_DEFAULT_OPTS_BASE \
   --ansi --no-bold \
   --marker='*' \
   --cycle \
   --layout=reverse --preview-window=wrap \
   --bind "'ctrl-\:toggle-preview'" \
   --bind "'ctrl-x:execute-silent(echo {+} | yankee)'"
set -x FZF_TMUX_DEFAULT_OPTS '-p 75%'
set -x FZF_DEFAULT_COMMAND 'fd --type=file --type=directory --hidden --color=always .'

# fzf.fish
set fzf_fd_opts --hidden
set fzf_preview_dir_cmd exa --all --classify --color=always
set fzf_dir_opts \
   --bind 'ctrl-v:execute(command nvim {} >/dev/tty)'
set fzf_git_status_opts \
   --bind 'ctrl-a:execute-silent(git add {})' \
   --bind 'ctrl-r:execute-silent(git reset {})' \
   --preview 'git diff --color=always HEAD (string sub --start=4 {+})'
set fzf_git_log_opts \
   --bind 'ctrl-o:execute-silent(git switch -d {})'

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

functions -e def
