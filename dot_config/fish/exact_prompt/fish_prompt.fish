function fish_prompt
  set last_status $status

  if is_ssh
    set_color $fish_color_host
    printf '%s ' (prompt_hostname)
    set_color normal
  end

  if jobs -q
    set_color $fish_color_jobs
    printf '%i! ' (count (jobs))
    set_color normal
  end

  if not __fish_prompt_status_normal $last_status
    set_color $fish_color_status
  else if test $USER = 'root'
    set_color $fish_color_user_root
  else
    set_color $fish_color_user
  end
  printf 'λ ' # prompt/user
  set_color normal
end
