command -q rg; or exit

function rge -w rg
  set results (rg -l $argv)

  if test -n "$results"
    commandline --replace "$EDITOR "(string escape $results | string join ' ')
    commandline --cursor (string length $EDITOR)
  end
end
