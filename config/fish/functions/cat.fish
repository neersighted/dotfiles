if command -sq bat
  function cat -d 'read and concaternate files (bat)'
    command bat $argv
  end
else
  function cat -d 'read and concaternate files (cat)'
    command cat $argv
  end
end
