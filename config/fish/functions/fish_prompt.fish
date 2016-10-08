function fish_prompt --description 'left prompt'
  if test -n "$SSH_CLIENT"; or test -n "$SSH_TTY"
    set_color $fish_color_hostname
    printf '%s ' (hostname -s)
    set_color normal
  end

  printf 'λ '
end
