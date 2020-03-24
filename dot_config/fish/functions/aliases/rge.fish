if command -sq rg
  function rge -w rg
    commandline -r "$VISUAL "(rg -l $argv | string join " ")
  end
end
