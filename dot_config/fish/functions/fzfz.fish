function fzfz -d 'select a directory to jump to using z' -a query
  if set target (z -l $query 2>/dev/null | string replace -r '^[0-9\.]+\s+' '' | fzf-tmux -d -- --no-sort --tiebreak=end --preview='peek {}' --query="$query")
    cd $target
  end
end
