function path_append -d 'append dir(s) to PATH'
  for dir in $argv
    test -n "$dir" -a -d $dir; or return
    set dir (realpath $dir)
    set PATH $PATH $dir
  end
end

