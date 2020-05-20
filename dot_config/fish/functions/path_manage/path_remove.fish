function path_remove -d 'remove entries from PATH' -a target
  string match -eq PATH $target; and set -e argv[1]; or set target PATH
  for entry in $argv
    while set i (contains -i $entry $$target)
      set -e $target\[$i]
    end
  end
end

