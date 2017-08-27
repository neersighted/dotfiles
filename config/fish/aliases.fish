functions -q prompt_hostname
  or alias prompt_hostname 'hostname'

function pyserve -d "serve files using python"
  if test -n "$argv"
    set -l port $argv
  else
    set -l port 8000
  end

  python3 -m http.server $port
end

alias vim 'nvim'
function nvim -d "vim improved"
  if test -n "$NVIM_LISTEN_ADDRESS"
    command nvr --remote $argv
  else
    command nvim $argv
  end
end

function vimstart -d "vim startup profile"
  vim --startuptime /dev/stdout +qall | rg -o "(\d{3}\.\d{3}): sourcing /([[:alnum:][:punct:]]+)" | sort
end
