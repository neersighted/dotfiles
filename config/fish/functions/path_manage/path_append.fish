function path_append -d 'append entries to PATH'
  for entry in $argv
    set i (contains -i $entry $PATH); and set -e PATH[$i]
    test -e $entry; and set -a PATH $entry
  end
end

