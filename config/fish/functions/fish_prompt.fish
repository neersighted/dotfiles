function fish_prompt --description 'left prompt'
  if set -q MOSH; or set -q SSH_CLIENT
    set_color $fish_color_hostname
    printf '%s ' (prompt_hostname) # hostname
    set_color normal
  end

  test "$USER" = "root"
    and set_color $fish_color_root
    or set_color $fish_color_user
  printf 'λ ' # prompt/user
  set_color normal
end
