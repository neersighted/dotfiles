function path_append -d 'append entries to PATH'
  for entry in $argv
    set -l i (contains -i $entry $PATH); and set -eg PATH[$i]
    test -e $entry; and set -gx PATH $PATH $entry
  end
end

