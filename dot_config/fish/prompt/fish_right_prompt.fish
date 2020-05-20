function fish_right_prompt
  set last_pipestatus $pipestatus
  set last_duration $CMD_DURATION

  set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  set -q prompt_minimal; and return

  prompt_version
  fish_git_prompt
  prompt_status $last_pipestatus
  prompt_duration $last_duration
end
