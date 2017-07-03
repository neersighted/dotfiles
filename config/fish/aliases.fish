#
# Aliases
#

# Real man's LS.
if ls --color=auto >/dev/null 2>&1
  alias ls 'command ls -Alh --color=auto'
else
  alias ls 'command ls -Alh -G'
end

# Fix backspace in ncmpcpp.
alias ncmpcpp 'tput smkx; command ncmpcpp'

#
# Functions
#

function pyserve -d "serve files using python"
  if test -n "$argv"
    set -l port $argv
  else
    set -l port 8000
  end

  python3 -m http.server $port
end

function sdl -d "run the last command with sudo"
    eval command sudo $history[1]
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
