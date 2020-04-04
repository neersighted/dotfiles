function pyserve -d 'serve files using python'
  if set -q $argv[1]
    set port $argv[1]
  else
    set port 8000
  end

  python -m http.server $port
end
