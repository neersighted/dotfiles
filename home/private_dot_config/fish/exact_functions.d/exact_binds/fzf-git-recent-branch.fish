function fzf-git-recent-branch
  set commandline (commandline)
  set branch (git branch --color=always --sort=authordate | fzf --tac --no-sort --query $commandline)

  if test -n "$branch"
    git checkout (builtin string trim --left --chars='* ' $branch)
  end

  commandline -f repaint
end
