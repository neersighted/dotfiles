function nodenv -d 'node environment manager'
  set command $argv[1]

  switch "$command"
  case rehash shell
    set -e argv[1]
    command nodenv sh-$command $argv | source
  case '*'
    command nodenv $argv
  end
end
