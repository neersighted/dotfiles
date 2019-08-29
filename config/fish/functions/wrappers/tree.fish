if command -sq exa
  __ls_colors
  function tree -w exa
    command exa --tree --long --git $argv
  end
end
