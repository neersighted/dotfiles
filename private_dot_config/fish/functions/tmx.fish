function tmx -d 'quickly attach to or create a new tmux session' -a query
  set session (tmux list-sessions -F '#{session_name}' | fzf-tmux -d -- --tac --print-query)[-1]
  test -z "$session"; and return
  
  if is_tmux
    if not tmux has-session -t $session &>/dev/null
      tmux new -d -s $session
    end
    tmux switch -t $session
  else
    tmux new -A -s $session
  end
end
