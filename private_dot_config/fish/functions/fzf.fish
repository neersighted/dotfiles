command -q fzf; or exit

function fzf --wraps=fzf
  if is_tmux
    fzf-tmux $FZF_TMUX_DEFAULT_OPTS -- $argv
  else
    command fzf $argv
  end
end
