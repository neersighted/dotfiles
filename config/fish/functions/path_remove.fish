function path_remove -a entry -d 'remove entry from PATH'
  test -n "$entry"; or return

  for i in (seq 1 (count $PATH))
    test -n "$PATH[$i]"
    and test $PATH[$i] = $entry
    and set -e PATH[$i]
  end
end

