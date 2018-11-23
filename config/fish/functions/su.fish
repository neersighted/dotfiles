function su -d 'become another user'
  if test -z "$argv"
    if command -sq sudo
      command sudo -E -s
    else
      command su -m
    end
  else
    command su $argv
  end
end

