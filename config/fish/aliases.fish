alias ls 'command ls --color=auto'
alias la 'command ls -A --color=auto'
alias ll 'command ls -Alh --color=auto'

# Fix backspace in ncmpcpp.
function ncmpcpp -d "ncurses mpd client"
  tput smkx
  command ncmpcpp
end

function pyserve -d "serve files using python"
  if test -n "$argv"
    set -l port $argv
  else
    set -l port 8000
  end

  python3 -m http.server $port
end

function vim -d "vi improved"
  if test -n "$NVIM_LISTEN_ADDRESS"
    command nvr --remote $argv
  else
    command nvim $argv
  end
end

function vimstart -d "vim startup profile"
  vim --startuptime /dev/stdout +qall | rg -o "(\d{3}\.\d{3}): sourcing /([[:alnum:][:punct:]]+)" | sort
end
