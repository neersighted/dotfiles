function path_list -d "lists elements in PATH (newline seperated)"
  sh -c 'echo $PATH' | tr ':' '\n'
end
