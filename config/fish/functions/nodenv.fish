function nodenv -d 'node environment manager'
  set command $argv[1]
  set -e argv[1]

  switch $command
  case rehash shell
    command nodenv sh-$command $argv | source
  case '*'
    command nodenv $command $argv
  end
end
