function path_list -d 'lists elements in PATH (newline seperated)' -a target
  string match -eq PATH $target; and set -e argv[1]; or set target PATH
  string escape $$target
end
