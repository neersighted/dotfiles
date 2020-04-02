#
# core
#

# editor
set -Ux EDITOR nvim
set -Ux VISUAL $EDITOR

# pager
set -Ux PAGER less
set -Ux LESS '--RAW-CONTROL-CHARS --tabs=4'
set -Ux LESSHISTFILE $XDG_DATA_HOME/less/history

#
# toolchains
#

# golang
set -Ux GOENV_ROOT $XDG_DATA_HOME/goenv
set -Ux GOENV_GOPATH_PREFIX $XDG_DATA_HOME/go
set -Ux GOBIN $XDG_DATA_HOME/go/bin

# haskell
set -Ux STACK_ROOT $XDG_DATA_HOME/stack

# node.js
set -Ux NODENV_ROOT $XDG_DATA_HOME/nodenv
set -Ux NODE_REPL_HISTORY $XDG_DATA_HOME/node/repl_history
set -Ux NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -Ux NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm

# python
set -Ux PYENV_ROOT $XDG_DATA_HOME/pyenv
set -Ux PIPX_HOME $XDG_DATA_HOME/pipx
set -Ux PIPX_BIN_DIR $XDG_DATA_HOME/pipx/bin
set -Ux PYLINTHOME $XDG_CACHE_HOME/pylint

# ruby
set -Ux RBENV_ROOT $XDG_DATA_HOME/rbenv
set -Ux IRBRC $XDG_CONFIG_HOME/irb/irbrc
set -Ux GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
set -Ux BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
set -Ux BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -Ux BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle

# rust
set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
set -Ux CARGO_HOME $XDG_DATA_HOME/cargo

#
# tools
#

# aws
set -Ux AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config
set -Ux AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials

# ccache
set -Ux CCACHE_DIR $XDG_CACHE_HOME/ccache

# homebrew
set -Ux HOMEBREW_AUTO_UPDATE_SECS 86400

# gnupg
set -Ux GNUPGHOME $HOME/.gnupg

# httpie
set -Ux HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie

# libvirt
set -Ux LIBVIRT_DEFAULT_URI qemu:///system

# lsof
set -Ux LSOFDEVCACHE $XDG_CACHE_HOME/lsof

# (n)vim
set -Ux VIM_CONFIG_PATH $XDG_CONFIG_HOME/nvim

# vagrant
set -Ux VAGRANT_HOME $XDG_DATA_HOME/vagrant
set -Ux VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1

#
# fzf
#

# core
set -Ux FZF_DEFAULT_COMMAND 'fd -c always -L -t file .'

# plugin (commands)
set -U FZF_FIND_FILE_COMMAND 'fd -c always -LH -E .git -t f $dir'
set -U FZF_OPEN_COMMAND 'fd -c always -LH -E .git -t f -t d $dir'
set -U FZF_CD_COMMAND 'fd -c always -L -t d . $dir'
set -U FZF_CD_WITH_HIDDEN_COMMAND 'fd -c always -LH -E .git -t d . $dir'

# plugin (ui)
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_TMUX 1
set -U FZF_TMUX_HEIGHT 75%

# plugin (preview)
set -U FZF_ENABLE_OPEN_PREVIEW 1
set -U FZF_PREVIEW_FILE_CMD '__fzf_preview_file'
set -U FZF_PREVIEW_DIR_CMD '__fzf_preview_dir'

# options
set -U FZF_BASE_OPTS '--ansi --no-bold --cycle'
set -U FZF_OPEN_OPTS '--tiebreak=end,length,index'
set -U FZF_CD_OPTS "--preview='$FZF_PREVIEW_DIR_CMD {}'"
