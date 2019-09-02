function fish_title -a cmd
  set basename (string replace -r '^.*/' '' $PWD)
  set cwd (short_home $PWD)

  if test -n "$cmd"
    printf '%s: %s' $basename $cmd
  else
    printf '%s %s' $_ $cwd
  end
end
