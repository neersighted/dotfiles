function ls
  if type -q exa >/dev/null 2>&1
    command exa --git $param $argv
  else
    set -l param --color=auto
    if isatty 1
      set param $param --indicator-style=classify
    end
    command ls $param $argv
  end
end
