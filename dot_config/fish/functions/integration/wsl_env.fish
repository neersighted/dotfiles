function wsl_env
  if not is_wsl
    printf '%s: not running in WSL' (status function)
  end

  set -l options 'p/translate' 'l/path'

  argparse $options -- $argv
  or return

  set -l name $argv[1]
  set -l flags

  if not set -q $name
    set -l value (cmd.exe /q /c echo %$name% 2>/dev/null | string trim)

    if set -q _flag_p
      set -a flags p
      set value (wslpath -u $value)
    end

    if set -q _flag_l
      set -a flags l
      set -gx --path $name $value
    else
      set -gx $name $value
    end

    if test -n "$flags"
      set name (printf '%s/%s' $name $flags)
    end

    printf '$%s imported: add to $WSLENV for faster startup' $name
  end
end
