function fish_prompt --description 'left prompt'
  if set -q SSH_CONNECTION
    set_color $fish_color_host
    printf '%s ' (prompt_hostname) # hostname
    set_color normal
  end

  test $USER = 'root'
    and set_color $fish_color_user_root
    or set_color $fish_color_user
  printf 'λ ' # prompt/user
  set_color normal
end
