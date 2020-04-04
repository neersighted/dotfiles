function path_append -d 'append entries to PATH' -a target
  string match -eq PATH $target; and set -e argv[1]; or set -l target PATH
  for entry in $argv
    set i (contains -i $entry $$target); and set -e $target\[$i]
    test -e $entry; and set -a $target $entry
  end
end

