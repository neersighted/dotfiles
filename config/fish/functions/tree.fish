__ls_colors
if command -sq exa
  function tree -w exa -d 'display directory tree (exa)'
    command exa --tree --long --git $argv
  end
else if command -sq tree
  function tree -d 'display directory tree (tree)'
    command tree $argv
  end
end
