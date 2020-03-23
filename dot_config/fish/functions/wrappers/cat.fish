if command -q bat
  function cat -w bat
    command bat $argv
  end
end
