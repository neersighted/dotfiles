command -q rg; or exit

function rg
  if isatty stdout
    set -lx LESS --no-init --quit-if-one-screen $LESS
    command rg -p $argv | $PAGER
  else
    command rg $argv
  end
end
