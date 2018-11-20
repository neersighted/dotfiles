function upcate -a target path -d 'locate a target upwards in the directory tree'
  if test -z "$path"
    set path $PWD
  end

  while test $path != /
    if test -e $path/$target
      echo $path
      return
    else
      set path (builtin realpath $path/..)
    end
  end

  return 1
end
