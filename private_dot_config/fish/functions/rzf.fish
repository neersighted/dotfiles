command -q rg; and command -q fzf; or exit

function rzf -w rg
    set results (
      rg --line-number --color=always $argv |
      fzf --multi \
        --delimiter : --with-nth=1,3 \
        --preview 'bat --style=numbers --highlight-line={2} {1} --color=always' \
        --preview-window +{2}-/2 |
      string split : -f 1
    )

  if test -n "$results"
    commandline --replace "$EDITOR "(string escape $results | string join ' ')
    commandline --cursor (string length $EDITOR)
  end
end
