function path_remove -a entry -d 'remove entry from PATH'
  test -n "$entry"; or return
  contains "$entry" $PATH; and return

  for i in (seq (count $PATH) -1 1)
    test $PATH[$i] = $entry
    and set -e PATH[$i]
  end
end

