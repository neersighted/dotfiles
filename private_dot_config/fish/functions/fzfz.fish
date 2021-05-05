command -q fzf; or exit

function fzfz -d 'select a directory to jump to using z' -a query
  if set target (z -l $query 2>/dev/null | string replace -r '^[0-9\.]+\s+' '' | fzf --no-sort --tiebreak=end --query="$query")
    commandline --replace "cd $target"
    commandline -f execute
  end
end
