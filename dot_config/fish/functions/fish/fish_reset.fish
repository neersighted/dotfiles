function fish_reset --description 'reset local fish configuration'
  # erase all universal variables
  for entry in (set -U)
    set variable (string split ' ' $entry)[1]
    echo "reset $variable"
    set -eU $variable
  end

  # reload configuration
  fish_reload
end