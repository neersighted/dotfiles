# Vim improved!
function vim
  if test -n "$NVIM_LISTEN_ADDRESS"
    command nvr --remote $argv
  else
    command nvim $argv
  end
end

# Real man's LS.
if ls --color=auto >/dev/null 2>&1
  alias ls 'ls -Alh --color=auto'
else
  alias ls 'ls -Alh -G'
end

# Quick Vim benchmark.
function vimstart
  vim --startuptime /dev/stdout +qall | sort -k3 | grep --color=never -oP "(\d{3}\.\d{3}): sourcing /([[:alnum:][:punct:]]+)"
end
