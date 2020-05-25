if command -q exa
  function ls -w exa
    command exa --classify --git --group $argv
  end
end
