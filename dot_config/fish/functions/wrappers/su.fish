function su
  if test -z "$argv"
    if command -q sudo
      command sudo -E -s
    else
      command su -m
    end
  else if test "$argv[1]" = '-l'; and command -q sudo
    command sudo -i
  else
    command su $argv
  end
end
