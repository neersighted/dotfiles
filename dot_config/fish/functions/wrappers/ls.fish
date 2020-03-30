if command -q exa
  function ls -w exa
    command exa --classify --git --group $argv
  end
else if command ls --version &>/dev/null
  function ls
    command ls --color=auto --classify $param $argv
  end
else if command ls -G / &>/dev/null
  if command ls -@ / &>/dev/null
    function ls
      command ls -@ -G $argv
    end
  else
    function ls
      command ls -G $argv
    end
  end
end
