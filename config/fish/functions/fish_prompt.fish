function fish_prompt --description 'left prompt'
  if test -n "$SSH_CLIENT"; or test -n "$SSH_TTY"
    set_color $fish_color_hostname
    printf '%s ' (hostname -s) # hostname
    set_color normal
  end

  test "$USER" = "root"; and set_color $fish_color_root; or set_color $fish_color_user
  printf 'λ ' # prompt/user
  set_color normal
end
