function src -d 'reload fish configuration'
  # reload all config fragments
  for fragment in $__fish_config_dir/conf.d/*
    test -f $fragment -a -r $fragment; and source $fragment
  end

  # reload main config
  test -f $__fish_config_dir/config.fish; and source $__fish_config_dir/config.fish
end
