command -q vim-startuptime; or exit

function vim-startuptime
  if isatty stdout
    set -lx -p LESS --no-init --quit-if-one-screen
    command vim-startuptime $argv | $PAGER
  else
    command vim-startuptime $argv
  end
end
