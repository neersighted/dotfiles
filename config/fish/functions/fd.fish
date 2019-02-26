if command -sq fdfind
  function fd -d 'simple and fast alternative to find'
    command fdfind $argv
  end
else
  function fd -d 'simple and fast alternative to find'
    command fd $argv
  end
end
