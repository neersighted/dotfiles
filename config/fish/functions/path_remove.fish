function path_remove -d 'remove entries from PATH'
  for entry in $argv
    while set -l i (contains -i $entry $PATH)
      set -e PATH[$i]
    end
  end
end

