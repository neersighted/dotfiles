function pyserve -d 'serve files using python'
  set -l port
  if test -n $argv
    set port $argv[1]
  else
    set port 8000
  end

  python3 -m http.server $port
end
