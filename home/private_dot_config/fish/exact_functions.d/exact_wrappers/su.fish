function su
  if not set -q argv[1]
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
