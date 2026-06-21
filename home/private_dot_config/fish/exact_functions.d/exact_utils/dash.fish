function dash -d 'offline documentation viewer'
  if set -q argv[1]
    open dash://$argv
  else
    open -a Dash
  end
end
