function assh -d 'amnesiac ssh (ignores known hosts)'
  command ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $argv
end
