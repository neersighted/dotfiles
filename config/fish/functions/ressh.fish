function ressh -d 'reconnect multiplexed ssh' 
  ssh -O exit $argv
  ssh $argv
end
