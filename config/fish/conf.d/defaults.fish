set -q fish_initialized; and exit

#
# core
#

# fish
set -U fish_greeting
set -U fish_key_bindings fish_default_key_bindings

# editor
set -Ux VISUAL nvim
set -Ux EDITOR $VISUAL

# pager
set -Ux PAGER less
set -Ux LESS '--RAW-CONTROL-CHARS --tabs=4'
set -Ux LESSHISTFILE $XDG_CACHE_HOME/lesshist

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
set -Ux NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -Ux NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm

# python
set -Ux PYENV_ROOT $XDG_DATA_HOME/pyenv
set -Ux PIPX_HOME $XDG_DATA_HOME/pipx/venvs
set -Ux PIPX_BIN_DIR $XDG_DATA_HOME/pipx/bin
set -Ux PIPENV_SHELL_FANCY 1
set -Ux PIPENV_VENV_IN_PROJECT 1
set -Ux PYLINTHOME $XDG_CACHE_HOME/pylint

# ruby
set -Ux RBENV_ROOT $XDG_DATA_HOME/rbenv
set -Ux GEM_HOME $XDG_DATA_HOME/gem
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

# gnupg
set -Ux GNUPGHOME $HOME/.gnupg

# httpie
set -Ux HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie

# libvirt
set -Ux LIBVIRT_DEFAULT_URI qemu:///system

# (n)vim
set -Ux VIM_CONFIG_PATH $XDG_CONFIG_HOME/nvim

# vagrant
set -Ux VAGRANT_HOME $XDG_DATA_HOME/vagrant
set -Ux VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1

#
# fzf
#

# Handle Ubuntu/Debian fd.
set -l fd fd
if command -sq fdfind
  set fd fdfind
end

# core
set -Ux FZF_DEFAULT_COMMAND "$fd --type file --type symlink"

# plugin (commands)
set -U FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND
set -U FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set -U FZF_CD_COMMAND "$fd --type directory --follow"
set -U FZF_CD_WITH_HIDDEN_COMMAND "$fd --type directory --follow --hidden --exclude .git"

# plugin (ui)
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_TMUX 1
set -U FZF_TMUX_HEIGHT 25%

# plugin (preview)
set -U FZF_ENABLE_OPEN_PREVIEW 1
set -U FZF_PREVIEW_FILE_COMMAND 'head -n 10'
set -U FZF_PREVIEW_DIR_COMMAND 'ls'

# local
set -U FZF_BASE_OPTS "--height $FZF_TMUX_HEIGHT --no-bold"
