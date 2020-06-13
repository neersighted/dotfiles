command -q exa; or exit

function tree -w exa
  command exa --tree --long --git $argv
end
