function path_prepend --d 'prepend dir(s) to PATH'
  for dir in $argv[-1..1]
    test -n "$dir" -a -d $dir; or return
    set dir (realpath $dir)
    set PATH $dir $PATH
  end
end

