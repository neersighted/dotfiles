function fish_title -a cmd --description 'terminal title'
  test -z "$cmd"; and set cmd $_
  printf '%s (%s)' $cmd $PWD
end
