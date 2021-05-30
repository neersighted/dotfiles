function fish_right_prompt
  set last_pipestatus $pipestatus
  set last_duration $CMD_DURATION

  set -q repainting; and set -e repainting; and return

  if fish_is_root_user
    set_color $fish_color_cwd_root
  else
    set_color $fish_color_cwd
  end
  prompt_pwd

  prompt_version
  prompt_git
  prompt_status $last_pipestatus
  prompt_duration $last_duration
end
