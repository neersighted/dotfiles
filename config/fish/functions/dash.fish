if test (uname) = 'Darwin'
  function dash -d 'offline documentation viewer'
    if test -n "$argv"
      open dash://$argv
    else
      open -a Dash
    end
  end
end
