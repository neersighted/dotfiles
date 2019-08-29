function fish_right_prompt
  set last_status $status
  set last_duration $CMD_DURATION

  set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  set -q prompt_minimal; and return

  __fish_version_prompt
  __fish_git_prompt
  __fish_status_prompt $last_status
  __fish_timer_prompt $last_duration
end
