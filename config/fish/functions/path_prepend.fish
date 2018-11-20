function path_prepend -d 'prepend entries to PATH'
  for entry in $argv[-1..1]
    test -e $entry; and set PATH $entry $PATH
  end
end

