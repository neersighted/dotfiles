function vimstart -d "vim startup profile"
  nvim --startuptime /dev/stdout +qall | rg -o "(\d{3}\.\d{3}): sourcing /([[:alnum:][:punct:]]+)" | sort
end
