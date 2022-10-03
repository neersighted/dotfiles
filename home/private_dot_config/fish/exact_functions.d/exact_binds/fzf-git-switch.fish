function fzf-git-switch
  set branch (git branch --color=always --sort=committerdate | fzf --tac --no-sort --query (commandline))

  if test -n "$branch"
    git checkout (builtin string trim --left --chars='* ' $branch)
  end

  commandline -f repaint
end
