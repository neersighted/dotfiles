function path_append -d 'append entries to PATH'
  for entry in $argv
    test -e $entry; and set PATH $PATH $entry
  end
end

