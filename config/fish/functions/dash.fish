if test (uname) = 'Darwin'
  function dash -d 'offline documentation viewer'
    open dash://$argv
  end
end
