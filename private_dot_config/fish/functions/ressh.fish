function ressh -d 'reconnect multiplexed ssh'
  dessh $argv
  ssh $argv
end
