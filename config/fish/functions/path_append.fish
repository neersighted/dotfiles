function path_append -a dir -d 'append dir to PATH'
  test -n "$dir" -a -d $dir; or return
  set dir (realpath $dir)

  path_remove $dir
  set PATH $PATH $dir
end
