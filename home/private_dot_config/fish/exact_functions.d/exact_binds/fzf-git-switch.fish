function fzf-git-switch
  if git rev-parse --git-dir >/dev/null 2>&1
    set -f branch (git branch --color=always --sort=-committerdate | fzf --tmux center,80,20 --no-sort --query (commandline))

    if test -n "$branch"
      git switch (builtin string trim --left --chars='* ' $branch)
    end
  end

  commandline -f repaint
end
