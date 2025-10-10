function fzf-git-commit
  set commit (git log --no-merges --color=always | fzf --scheme=history | string split -f 1 ' ')

  commandline --insert $commit
end
