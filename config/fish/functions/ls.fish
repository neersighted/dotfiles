command ls --color >/dev/null 2>&1
  and set coreutils "gnu"
  or set coreutils "bsd"

function ls
  if type -q exa >/dev/null 2>&1
    command exa --git $param $argv
  else
    if test "$coreutils" = "gnu"
      set -l param --color=auto
      if isatty 1
        set param $param --indicator-style=classify
      end
      command ls $param $argv
    else
      command ls -G $argv
    end
  end
end
