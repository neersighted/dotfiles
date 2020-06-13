command -q exa; or exit

function ls -w exa
  command exa --classify --git --group $argv
end
