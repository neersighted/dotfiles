command -q rg; or exit

function rge -w rg
  set results (rg -l $argv | string join " ")

  if test -n "$results"
    commandline --replace "$EDITOR $results"
    commandline --cursor (string length $EDITOR)
  end
end
