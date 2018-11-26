function fish_right_prompt --description 'right prompt'
  set -l last_status $status

  if set -q prompt_minimal
    return
  end

  test $USER = 'root'
    and set_color $fish_color_cwd_root
    or set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  __fish_git_prompt

  if set -q VIRTUAL_ENV
    set -l venv (basename $VIRTUAL_ENV)
    if test $venv = '.venv'
      set venv (basename (dirname $VIRTUAL_ENV))
    end

    set_color $fish_color_venv
    printf ' <%s>' $venv
    set_color normal
  end

  set -l job_count (count (jobs))
  if test $job_count -ne 0
    set_color $fish_color_jobs
    printf ' {%i}' $job_count
    set_color normal
  end

  if test $last_status -ne 0
    set_color $fish_color_status
    printf ' [%i]' $last_status
    set_color normal
  end
end
