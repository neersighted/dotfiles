function rbenv -d 'ruby environment manager'
  set command $argv[1]
  set -e argv[1]

  switch $command
  case rehash shell
    command rbenv sh-$command $argv | source
  case '*'
    command rbenv $command $argv
  end
end
