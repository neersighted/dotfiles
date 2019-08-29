function fish_prompt --description 'left prompt'
  set last_status $status

  if set -q SSH_CONNECTION
    set_color $fish_color_host
    printf '%s ' $hostname # hostname
    set_color normal
  end

  if jobs -q
    set_color $fish_color_jobs
    printf '%i! ' (count (jobs))
    set_color normal
  end

  if test $last_status -ne 0
    set_color $fish_color_status
  else if test $USER = 'root'
    set_color $fish_color_user_root
  else
    set_color $fish_color_user
  end
  printf 'λ ' # prompt/user
  set_color normal
end
