function nvim -d 'vim improved'
  if set -qx NVIM_LISTEN_ADDRESS
    command nvr --remote $argv
  else
    command nvim $argv
  end
end
