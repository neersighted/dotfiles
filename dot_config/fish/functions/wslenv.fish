is_wsl; or exit

function wslenv
  set -a options 'p/path' 'l/list'

  argparse $options -- $argv
  or return

  set name $argv[1]

  set -q _flag_p; and set -a flags p
  set -q _flag_l; and set -a flags l

  if test -n "$flags"
    set fullname (printf '%s/%s' $name (string join '' $flags))
  else
    set fullname $name
  end

  if not contains $fullname $WSLENV
    set placeholder %$name%
    set value (cmd.exe /q /c echo $placeholder 2>/dev/null | string trim)

    # handle blank/empty variables
    if test "$value" = "$placeholder"
      set value ''
    end

    if contains p $flags
      set value (wslpath -u $value)
    end

    if contains l $flags
      set -gx --path $name $value
    else
      set -gx $name $value
    end

    printf '%s imported: add to $WSLENV for faster startup\n' $fullname
  end
end
