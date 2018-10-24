function sudo -d 'execute a command as another user'
  if test $argv[1] = 'nvim'
    command sudo -e $argv[2..-1]
  else
    command sudo $argv
  end
end
