command -q rg; or exit

function rge -w rg
  set -a options 'L/no-lines'

  argparse $options -- $argv; or return

  set results (rg --line-number $argv)

  if set -q _flag_L
    set results (string split -f 1 : $results)
  else
    set results (string match -r '[^:]*:[^:]*' $results)
  end

  if test -n "$results"
    commandline --replace "$EDITOR "(string escape $results | string join ' ')
    commandline --cursor (string length $EDITOR)
  end
end
