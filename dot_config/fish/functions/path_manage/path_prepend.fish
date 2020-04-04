function path_prepend -d 'prepend entries to PATH' -a target
  string match -eq PATH $target; and set -e argv[1]; or set -l target PATH
  for entry in $argv[-1..1]
    set i (contains -i $entry $$target); and set -e $target\[$i]
    test -e $entry; and set -p $target $entry
  end
end

