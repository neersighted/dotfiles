function src -d 'reload fish configuration'
  # reload all config fragments
  for fragment in (path filter -fr $__fish_config_dir/conf.d/*)
    source $fragment
  end

  # reload main config
  path is -f $__fish_config_dir/config.fish; and source $__fish_config_dir/config.fish
end
