function fish_reset --description 'reset local fish configuration'
  # erase all universal variables
  for setting in $fish_settings
    set variable (string split ' ' $setting)[1]
    echo "reset $variable"
    set -eU $variable
  end

  # reinitialize on next load
  set -eU fish_initialized
  set -eU fish_settings

  # reload configuration
  fish_reload
end
