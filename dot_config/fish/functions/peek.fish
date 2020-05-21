function peek -a target
  test -e $target; or return
  test -L $target; and set target (builtin realpath $target)

  if test -d $target
    exa --color=always --tree --level 2 --classify $target
  else
    file --mime $target
    if file --mime-encoding $target | string match -eq 'binary'
      file --uncompress $target | fold -s
      hexyl --color always --border none --no-squeezing --bytes 512 $target
    else
      bat --color always --wrap never --style=numbers,changes --line-range :100 $target
    end
  end
end
