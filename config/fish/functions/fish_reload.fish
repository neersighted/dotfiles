function fish_reload -d 'reload fish configuration'
  # reload all config fragments
  for fragment in $XDG_CONFIG_HOME/fish/conf.d/*
    test -f $fragment -a -r $fragment; and source $fragment
  end
  # reload main config
  source $XDG_CONFIG_HOME/fish/config.fish

  # rescope universal exports
  for export in (set -Ux)
    set -eg (string split ' ' $export)[1]
  end
end
