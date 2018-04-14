function pyserve -d "serve files using python"
  if test -n "$argv"
    set -l port $argv
  else
    set -l port 8000
  end

  python3 -m http.server $port
end
