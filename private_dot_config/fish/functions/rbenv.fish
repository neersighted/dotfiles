command -q rbenv; or exit

function rbenv -d 'ruby environment manager'
  set command $argv[1]

  switch $command
  case rehash shell
    set -e argv[1]
    command rbenv sh-$command $argv | source
  case '*'
    command rbenv $argv
  end
end
