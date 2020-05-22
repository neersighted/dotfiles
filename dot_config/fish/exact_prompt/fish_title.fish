function fish_title -a cmd
  set basename (string replace -r '^.*/' '' $PWD)
  set cwd (short_home $PWD)

  if is_ssh
    printf '(%s) ' (prompt_hostname)
  end

  if test -n "$cmd"
    printf '%s: %s' $basename $cmd
  else
    printf '%s %s' (status current-command) $cwd
  end
end
