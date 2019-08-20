if command -sq bat
  function cat -w bat
    command bat $argv
  end
end
