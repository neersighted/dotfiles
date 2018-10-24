function goenv -d 'go environment manager'
  set command $argv[1]
  set -e argv[1]

  switch $command
  case rehash shell
    source (goenv sh-$command $argv | psub)
  case '*'
    command goenv $command $argv
  end
end
