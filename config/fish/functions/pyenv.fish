function pyenv -d 'python environment manager'
  set command $argv[1]
  set -e argv[1]

  switch $command
  case activate deactivate rehash shell
    command pyenv sh-$command $argv | source
  case '*'
    command pyenv $command $argv
  end
end
