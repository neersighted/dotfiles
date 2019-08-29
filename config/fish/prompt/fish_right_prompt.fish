function fish_right_prompt
  set last_status $status
  set last_duration $CMD_DURATION

  set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  set -q prompt_minimal; and return

  fish_version_prompt
  fish_git_prompt
  fish_status_prompt $last_status
  fish_timer_prompt $last_duration
end
