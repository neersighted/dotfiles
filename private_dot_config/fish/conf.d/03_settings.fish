#
# core
#

# editor
set -qx EDITOR; or set -Ux EDITOR nvim
set -qx VISUAL; or set -Ux VISUAL $EDITOR

# pager
set -qx PAGER; or set -Ux PAGER less

# fish
set -qU fish_greeting; or set -U fish_greeting
set -qU fish_term24bit; or set -U fish_term24bit 1
set -qU fish_key_bindings; or set -U fish_key_bindings fish_default_key_bindings
set -qU fish_features; or set -U fish_features 3.1

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

# less
set -x LESS '--mouse --RAW-CONTROL-CHARS --tabs=2'
set -x LESSHISTFILE $XDG_DATA_HOME/less/history

# libvirt
set -qx LIBVIRT_DEFAULT_URI; or set -Ux LIBVIRT_DEFAULT_URI qemu:///system

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
