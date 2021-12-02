function _fzf_preview_changed_file
  set git_status (string sub --length 2 $argv[1])

  # extract path from renamed files
  if test (string sub --length 1 $git_status) = 'R'
    set path (string split -- "-> " $argv[2])[-1]
  else
    set path $argv[2]
  end

  # as we require fish 3.2+ we can safely depend on qmark-noglob
  set -la fish_features qmark-noglob

  switch $git_status
    # summary: show summarized status
    case '##'
      git -c color.status=always status --long
    # untracked files: show contents
    case '??'
      _fzf_preview_file $path
    # tracked files: emulate `git status` with `diff` output
    case '*'
      if string match -rq '\S.' $git_status
        echo 'Changes to be committed:'
        git -c color.diff=always diff --staged -- $path
        echo
      end
      if string match -rq '.\S' $git_status
        echo 'Changes not staged for commit:'
        git -c color.diff=always diff -- $path
      end
  end
end
