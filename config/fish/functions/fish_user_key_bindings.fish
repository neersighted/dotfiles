function fish_user_key_bindings -d 'user keybindings'
  bind ! __history_previous_command
  bind \$ __history_previous_arguments
  bind \es __sudo_toggle
end
