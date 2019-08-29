if command -sq exa
  __ls_colors
  function ls -w exa
    command exa --git --group --classify $argv
  end
else if command ls --version >/dev/null 2>&1
  __ls_colors
  function ls
    set param --color=auto
    if isatty
        set -a param --indicator-style=classify
    end
    command ls $param $argv
  end
else if command ls -G / >/dev/null 2>&1
  function ls
    command ls -G $argv
  end
else if command ls --color / >/dev/null 2>&1
  function ls
    command ls --color $argv
  end
end
