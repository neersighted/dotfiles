function fish_prompt
  set last_status $status

  if is_ssh
    set_color $fish_color_host_remote
    printf '%s ' (prompt_hostname)
  end

  if jobs -q
    set_color $fish_color_jobs
    printf '%i! ' (count (jobs))
  end

  if not __prompt_status_normal $last_status
    set_color $fish_color_status
  else if fish_is_root_user
    set_color $fish_color_user_root
  else
    set_color $fish_color_user
  end
  printf 'λ ' # prompt/user
  set_color normal
end
