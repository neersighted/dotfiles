function nvim -d 'vim improved'
  if set -qg NVIM_LISTEN_ADDRESS
    command nvr --remote $argv
  else
    command nvim $argv
  end
end
