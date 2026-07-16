function toggle-sudo
  commandline -f expand-abbr
  set -l cmdline (commandline --tokens-expanded --current-process)

  if string match -rq '\.exe$' $cmdline[1]
    fish_commandline_prepend sudo.exe
  else if string match -eq $VISUAL[1] $cmdline[1]
    commandline --replace --current-process (string join ' ' sudoedit $cmdline[2..-1])
  else if string match -eq sudoedit $cmdline[1]
    commandline --replace --current-process (string join ' ' $VISUAL[1] $cmdline[2..-1])
  else
    for cmd in sudo doas please run0
      if command -q $cmd
        fish_commandline_prepend $cmd
        break
      end
    end
  end
end
