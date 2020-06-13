if not command -q git
  function prompt_git; end
  exit
end

function prompt_git
  set -q prompt_git_prefix; or set prompt_git_prefix '('
  set -q prompt_git_postfix; or set prompt_git_suffix ')'
  set -q prompt_git_seperator; or set prompt_git_seperator '|'
  set -q prompt_git_detached; or set prompt_git_detached ':'
  set -q prompt_git_upstream; or set prompt_git_upstream '⟳'
  set -q prompt_git_behind; or set prompt_git_behind '↓'
  set -q prompt_git_ahead; or set prompt_git_ahead '↑'
  set -q prompt_git_operation; or set prompt_git_operation ''
  set -q prompt_git_staged; or set prompt_git_staged '●'
  set -q prompt_git_unstaged; or set prompt_git_unstaged '✚'
  set -q prompt_git_unmerged; or set prompt_git_unmerged '✖'
  set -q prompt_git_untracked; or set prompt_git_untracked '…'
  set -q prompt_git_stashed; or set prompt_git_stashed '⚑'
  set -q prompt_git_clean; or set prompt_git_clean '✔'

  set -q prompt_git_color; or set prompt_git_color normal
  set -q prompt_git_color_branch; or set prompt_git_color_branch magenta
  set -q prompt_git_color_detached; or set prompt_git_color_detached cyan
  set -q prompt_git_color_upstream; or set prompt_git_color_upstream cyan
  set -q prompt_git_color_behind; or set prompt_git_color_behind $prompt_git_color
  set -q prompt_git_color_ahead; or set prompt_git_color_ahead $prompt_git_color
  set -q prompt_git_color_operation; or set prompt_git_color_operation yellow
  set -q prompt_git_color_staged; or set prompt_git_color_staged green
  set -q prompt_git_color_unstaged; or set prompt_git_color_unstaged red
  set -q prompt_git_color_unmerged; or set prompt_git_color_unmerged red
  set -q prompt_git_color_untracked; or set prompt_git_color_untracked $prompt_git_color
  set -q prompt_git_color_stashed; or set prompt_git_color_stashed blue

  set git_dir (command git rev-parse --git-dir 2>/dev/null); or return

  command git status --porcelain=v2 --branch -z | while read --list -z line
    switch $line[1]
      case \#
        switch $line[2]
          case branch.oid
            set oid $line[3]
          case branch.head
            set head $line[3]
            if test "$head" = "(detached)"
              set detached true
              set head (git describe --all --contains HEAD)
              or set head (string sub -l 8 $oid)
            end
          case branch.upstream
            set upstream $line[3]
          case branch.ab
            set ahead $line[3]
            set behind $line[4]
        end
      case {1,2}
        string match -rq '\w\.' $line[2]; and set staged (math $staged + 1)
        string match -rq '\.\w' $line[2]; and set unstaged (math $unstaged + 1)
      case u
        set unmerged (math $unmerged + 1)
      case \?
        set untracked (math $untracked + 1)
    end
  end

  if test -f $git_dir/refs/stash
    set stashed (command git rev-list --walk-reflogs --count refs/stash)
  end

  if test -d $git_dir/rebase-merge
    read step < $git_dir/rebase-merge/msgnum
    read total < $git_dir/rebase-merge/end
    if test -f $git_dir/rebase-merge/interactive
      set operation "REBASE-i"
    else
      set operation "REBASE-m"
    end
  else
    if test -d $git_dir/rebase-apply
      read step < $git_dir/rebase-apply/next
      read total < $git_dir/rebase-apply/last
      if test -f $git_dir/rebase-apply/rebasing
        set operation "REBASE"
      else if test -f $git_dir/rebase-apply/applying
        set operation "AM"
      else
        set operation "AM/REBASE"
      end
    else if test -f $git_dir/MERGE_HEAD
      set operation "MERGING"
    else if test -f $git_dir/CHERRY_PICK_HEAD
      set operation "CHERRY-PICKING"
    else if test -f $git_dir/REVERT_HEAD
      set operation "REVERTING"
    else if test -f $git_dir/BISECT_LOG
      set operation "BISECTING"
    end
  end

  if test -n "$step" -a -n "$total"
    set operation "$operation $step/$total"
  end

  set_color $prompt_git_color
  printf ' %s' $prompt_git_prefix

  set_color $prompt_git_color_branch
  if test -n "$detached"
    set_color $prompt_git_color_detached
    printf '%s' $prompt_git_detached
  end
  printf '%s' $head

  if test -n "$upstream"; and test (string replace -r '^.*/' '' $upstream) != "$head"
    set_color $prompt_git_color_upstream
    printf ' %s %s' $prompt_git_upstream $upstream
  end
  if test -n "$behind"; and test "$behind" != '-0'
    set_color $prompt_git_color_behind
    printf '%s%d' $prompt_git_behind (math $behind \* -1)
  end
  if test -n "$ahead"; and test "$ahead" != '+0'
    set_color $prompt_git_color_ahead
    printf '%s%d' $prompt_git_ahead $ahead
  end

  if test -n "$operation"
    set_color $prompt_git_color
    printf '%s' $prompt_git_seperator
    set_color $prompt_git_color_operation
    printf '%s' $operation
  end

  if test -n "$staged$unstaged$unmerged$untracked$stashed"
    set_color $prompt_git_color
    printf '%s' $prompt_git_seperator

    if test -n "$staged"
      set_color $prompt_git_color_staged
      printf '%s%d' $prompt_git_staged $staged
    end
    if test -n "$unstaged"
      set_color $prompt_git_color_unstaged
      printf '%s%d' $prompt_git_unstaged $unstaged
    end
    if test -n "$unmerged"
      set_color $prompt_git_color_unmerged
      printf '%s%d' $prompt_git_unmerged $unmerged
    end
    if test -n "$untracked"
      set_color $prompt_git_color_untracked
      printf '%s%d' $prompt_git_untracked $untracked
    end
    if test -n "$stashed"
      set_color $prompt_git_color_stashed
      printf '%s%d' $prompt_git_stashed $stashed
    end
  else if test -n "$prompt_git_clean"
    set_color $prompt_git_color
    printf '%s%s' $prompt_git_seperator $prompt_git_clean
  end

  set_color $prompt_git_color
  printf '%s' $prompt_git_suffix
end
