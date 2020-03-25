if command -q rg
  function rge -w rg
    set results (rg -l $argv | string join " ")

    if test -n "$results"
      commandline -r "$VISUAL $results"
      commandline -C (string length $VISUAL)
    end
  end
end
