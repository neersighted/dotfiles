function path_prepend -d 'prepend entries to PATH'
  for entry in $argv[-1..1]
    set -l i (contains -i $entry $PATH); and set -e PATH[$i]
    test -e $entry; and set PATH $entry $PATH
  end
end

