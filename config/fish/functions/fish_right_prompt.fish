function fish_right_prompt --description 'right prompt'
  set -l last_status $status
  set -l job_count (count (jobs))

  set -q prompt_minimal
    and return

  test "$USER" = "root"
    and set_color $fish_color_cwd_root
    or set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  __fish_git_prompt

  if not test $job_count -eq 0
    set_color $fish_color_jobs
    printf ' {%i}' $job_count
    set_color normal
  end

  if not test $last_status -eq 0
    set_color $fish_color_status
    printf ' [%i]' $last_status
    set_color normal
  end
end
