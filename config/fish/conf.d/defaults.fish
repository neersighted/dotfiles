set -q fish_initialized; and exit

#
# core
#

# fish
set -U fish_greeting

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
set -Ux GOPATH $XDG_DATA_HOME/go

# node.js
set -Ux NODENV_ROOT $XDG_DATA_HOME/nodenv
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
set -Ux GEM_SPEC_CACHE $XDG_CACHE_HOME/gem

# rust
set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
set -Ux CARGO_HOME $XDG_DATA_HOME/cargo

#
# tools
#

# (n)vim
set -Ux VIM_CONFIG_PATH $XDG_CONFIG_HOME/nvim

# gnupg
set -Ux GNUPGHOME $HOME/.gnupg

# ccache
set -Ux CCACHE_DIR $XDG_CACHE_HOME/ccache

# libvirt
set -Ux LIBVIRT_DEFAULT_URI qemu:///system

# httpie
set -Ux HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie

#
# fzf
#

# core
set -Ux FZF_DEFAULT_COMMAND 'fd --type file --type symlink'

# plugin (commands)
set -U FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND
set -U FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set -U FZF_CD_COMMAND 'fd --type directory --follow'
set -U FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --follow --hidden --exclude .git'

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
