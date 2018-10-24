if not set -qU fish_initialized
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
  set -U FZF_BASE_OPTS "--height $FZF_TMUX_HEIGHT" '--no-bold'
end

# colors
if test $COLORTERM = 'truecolor'
  set -x FZF_DEFAULT_OPTS $FZF_BASE_OPTS '--color=fg:#839496,bg:#002b36,hl:#eee8d5,fg+:#839496,bg+:#073642,hl+:#d33682 --color=info:#2aa198,prompt:#839496,pointer:#fdf6e3,marker:#fdf6e3,spinner:#2aa198'
else
  set -x FZF_DEFAULT_OPTS $FZF_BASE_OPTS '--color=fg:12,bg:8,hl:7,fg+:12,bg+:0,hl+:5 --color=info:6,prompt:12,pointer:15,marker:15,spinner:6'
end
