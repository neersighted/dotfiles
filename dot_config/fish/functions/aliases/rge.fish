if command -q rg
  function rge -w rg
    commandline $VISUAL (rg -l $argv)
  end
end
