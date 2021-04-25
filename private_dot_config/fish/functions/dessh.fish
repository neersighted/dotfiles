function dessh -d 'kill multiplexed ssh connection'
  ssh -O exit $argv
end
