if command -q exa
  function tree -w exa
    command exa --tree --long --git $argv
  end
end
