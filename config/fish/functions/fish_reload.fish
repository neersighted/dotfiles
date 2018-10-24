function fish_reload -d 'reload fish configuration'
  # clear key bindings
  functions -e fish_user_key_bindings

  # reload all config fragments
  for fragment in $XDG_CONFIG_HOME/fish/conf.d/*
    test -f $fragment -a -r $fragment; and source $fragment
  end
  # reload main config
  source $XDG_CONFIG_HOME/fish/config.fish
end
