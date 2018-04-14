function tree
  if type -q exa >/dev/null 2>&1
    command exa -lT --git $argv
  else
    command tree $argv
  end
end

