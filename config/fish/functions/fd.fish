if command -sq fdfind
  function fd
    command fdfind $argv
  end
end
