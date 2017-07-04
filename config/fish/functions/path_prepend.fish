function path_prepend -a dir -d 'prepend dir to PATH'
  test -n "$dir" -a -d $dir; or return
  set dir (realpath $dir)

  path_remove $dir
  set PATH $dir $PATH
end

