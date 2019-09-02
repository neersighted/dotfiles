if command -sq exa
  function ls -w exa
    command exa --classify --git --group $argv
  end
else if command ls --version >/dev/null 2>&1
  function ls
    command ls --color=auto --classify $param $argv
  end
else if command ls -G / >/dev/null 2>&1
  function ls
    command ls -@ -G $argv
  end
end
