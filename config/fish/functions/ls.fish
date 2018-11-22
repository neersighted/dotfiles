if command -sq exa
  __ls_colors
  function ls -w exa -d 'list contents of a directory (exa)'
    command exa --git --group --classify $argv
  end
else if command ls --version >/dev/null 2>&1
  __ls_colors
  function ls -d 'list contents of a directory (gnu)'
    set -l param --color=auto
    if isatty 1
        set param $param --indicator-style=classify
    end
    command ls $param $argv
  end
else if command ls -G / >/dev/null 2>&1
  function ls -d 'list contents of a directory (bsd)'
    command ls -G $argv
  end
else if command ls --color / >/dev/null 2>&1
  function ls -d 'list contents of a directory (solaris)'
    command ls --color $argv
  end
end
