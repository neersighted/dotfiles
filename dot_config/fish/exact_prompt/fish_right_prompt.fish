function fish_right_prompt
  set last_pipestatus $pipestatus
  set last_duration $CMD_DURATION

  set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  fish_version_prompt
  fish_git_prompt
  fish_status_prompt $last_pipestatus
  fish_duration_prompt $last_duration
end
