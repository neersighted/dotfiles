function fzfz -d 'select a directory to jump to using z'
  cd (z -l | string replace -r '^[0-9\.]+\s+' '' | fzf-tmux -d -- --no-sort --tiebreak=end --preview='peek {}')
end
