if command -q rg
  function rge -w rg
    set results (rg -l $argv | string join " ")

    if test -n "$results"
      commandline -r "$EDITOR $results"
      commandline -C (string length $EDITOR)
    end
  end
end
