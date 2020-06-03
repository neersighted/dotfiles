function tmx -d 'quickly attach to or create a new tmux session' -a query
  set session (tmux list-sessions -F '#{session_name}' | fzf-tmux -d -- --print-query)[-1]
  test -z "$session"; and return
  
  if is_tmux
    tmux switch -t $session
  else
    tmux new -A -s $session
  end
end
