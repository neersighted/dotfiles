set -q fish_initialized; and exit
set -U fish_settings

function setting -a var -a val -a export
  contains $var $fish_settings; or set -a fish_settings $var
  set -Ux $var $val
end

#
# core
#

# editor
setting EDITOR nvim
setting VISUAL $EDITOR

# pager
setting PAGER less
setting GIT_PAGER 'less --quit-if-one-screen --no-init'
setting LESS '--mouse --RAW-CONTROL-CHARS --tabs=2'
setting LESSHISTFILE $XDG_DATA_HOME/less/history

#
# toolchains
#

# golang
setting GOENV_ROOT $XDG_DATA_HOME/goenv
setting GOENV_GOPATH_PREFIX $XDG_DATA_HOME/go
setting GOBIN $XDG_DATA_HOME/go/bin

# haskell
setting STACK_ROOT $XDG_DATA_HOME/stack

# node.js
setting NODENV_ROOT $XDG_DATA_HOME/nodenv
setting NODE_REPL_HISTORY $XDG_DATA_HOME/node/repl_history
setting NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
setting NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
setting NPM_CONFIG_STORE_DIR $XDG_CACHE_HOME/pnpm

# python
setting PYENV_ROOT $XDG_DATA_HOME/pyenv
setting PIPX_HOME $XDG_DATA_HOME/pipx
setting PIPX_BIN_DIR $XDG_DATA_HOME/pipx/bin
setting POETRY_HOME $XDG_DATA_HOME/poetry
setting PYLINTHOME $XDG_CACHE_HOME/pylint

# ruby
setting RBENV_ROOT $XDG_DATA_HOME/rbenv
setting IRBRC $XDG_CONFIG_HOME/irb/irbrc
setting GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
setting BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
setting BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
setting BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle

# rust
setting RUSTUP_HOME $XDG_DATA_HOME/rustup
setting CARGO_HOME $XDG_DATA_HOME/cargo

#
# tools
#

# aws
setting AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config
setting AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials

# ccache
setting CCACHE_DIR $XDG_CACHE_HOME/ccache

# homebrew
setting HOMEBREW_AUTO_UPDATE_SECS 86400

# gnupg
setting GNUPGHOME $HOME/.gnupg

# httpie
setting HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie

# libvirt
setting LIBVIRT_DEFAULT_URI qemu:///system

# lsof
setting LSOFDEVCACHE $XDG_CACHE_HOME/lsof

# (n)vim
setting VIM_CONFIG_PATH $XDG_CONFIG_HOME/nvim

# wget
setting WGETRC $XDG_CONFIG_HOME/wget/wgetrc

# vagrant
setting VAGRANT_HOME $XDG_DATA_HOME/vagrant
setting VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1

#
# fzf
#

# core
setting FZF_DEFAULT_COMMAND 'fd -c always -L -t file .'

# plugin (commands)
setting FZF_FIND_FILE_COMMAND 'fd -c always -LH -E .git -t f . $dir'
setting FZF_OPEN_COMMAND 'fd -c always -LH -E .git -t f -t d . $dir'
setting FZF_CD_COMMAND 'fd -c always -L -t d . $dir'
setting FZF_CD_WITH_HIDDEN_COMMAND 'fd -c always -LH -E .git -t d . $dir'

# plugin (ui)
setting FZF_LEGACY_KEYBINDINGS 0
setting FZF_TMUX 1
setting FZF_TMUX_HEIGHT 75%

# plugin (preview)
setting FZF_ENABLE_OPEN_PREVIEW 1
setting FZF_PREVIEW_FILE_CMD '__fzf_preview_file'
setting FZF_PREVIEW_DIR_CMD '__fzf_preview_dir'

# options
setting FZF_BASE_OPTS '--ansi --no-bold --cycle'
setting FZF_OPEN_OPTS '--tiebreak=end,length,index'
setting FZF_CD_OPTS "--preview='$FZF_PREVIEW_DIR_CMD {}'"

functions -e setting
