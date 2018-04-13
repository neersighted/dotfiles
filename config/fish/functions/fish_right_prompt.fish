function fish_right_prompt --description 'right prompt'
  set -l last_status $status

  set -q prompt_minimal
    and return

  test "$USER" = "root"
    and set_color $fish_color_cwd_root
    or set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  type -q pretty-git-prompt
    and eval (pretty-git-prompt)

  if not test $last_status -eq 0
    set_color $fish_color_status
    printf ' [%i]' $last_status
    set_color normal
  end
end
