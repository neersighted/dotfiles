# defaults
set -qx EDITOR; or set -Ux EDITOR nvim
set -qx VISUAL; or set -Ux VISUAL $EDITOR
set -qx PAGER; or set -Ux PAGER less

# bat
set -x BAT_THEME Nord
set -x BAT_PAGER 'less --quit-if-one-screen --no-init'

# bd
set BD_OPT 'insensitive'

# fish
set -qU fish_greeting; or set -U fish_greeting
set -qU fish_term24bit; or set -U fish_term24bit 1
set -qU fish_key_bindings; or set -U fish_key_bindings fish_default_key_bindings
set -qU fish_features; or set -U fish_features 3.1

# fzf
set FZF_DEFAULT_OPTS_BASE \
   --ansi --no-bold \
   --marker='*' \
   --cycle \
   --layout=reverse --preview-window=wrap \
   --bind "'ctrl-\:toggle-preview'" \
   --bind "'ctrl-x:execute-silent(echo {+} | clipboard-provider copy)'"
set -x FZF_TMUX_DEFAULT_OPTS '-p 75%'
set -x FZF_DEFAULT_COMMAND 'fd --type=file --type=directory --hidden --color=always .'

# fzf.fish
set fzf_fd_opts --hidden
set fzf_preview_dir_cmd exa --all --classify --color=always
set fzf_dir_opts \
   --bind 'ctrl-v:execute(command nvim {} >/dev/tty)'
set fzf_git_status_opts \
   --preview '_fzf_preview_changed_file {} {2..}'
set fzf_git_log_opts \
   --bind 'ctrl-o:execute-silent(git switch -d {})'

# homebrew
is_macos; and set -x HOMEBREW_AUTO_UPDATE_SECS 86400

# less
set -x LESS '--mouse --RAW-CONTROL-CHARS --tabs=2'

# libvirt
if is_linux
   set -qx LIBVIRT_DEFAULT_URI; or set -Ux LIBVIRT_DEFAULT_URI qemu:///system
end

# pip
set -x PIP_REQUIRE_VIRTUALENV 1

# vagrant
is_wsl; and set -x VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1
