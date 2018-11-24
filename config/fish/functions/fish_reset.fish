function fish_reset --description 'reset local fish configuration'
  # erase all universal variables
  for entry in (set -U)
    set -l variable (string split ' ' $entry)[1]

    if test $variable = 'fish_key_bindings'
      continue
    end

    echo "reset $variable"
    set -eU $variable
  end

  # reload configuration
  fish_reload
end
