function fish_title -a cmd
  set basename (string replace -r '^.*/' '' $PWD)
  set cwd (string replace -r '^'"$HOME"'($|/)' '~$1' $PWD)

  if test -n "$cmd"
    printf '%s: %s' $basename $cmd
  else
    printf '%s %s' $_ $cwd
  end
end
