command -q rg; or exit

function rg
  if isatty stdout
    command rg -p $argv | $PAGER
  else
    command rg $argv
  end
end
