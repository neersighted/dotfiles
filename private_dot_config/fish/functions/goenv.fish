command -q goenv; or exit

function goenv -d 'go environment manager'
  set command $argv[1]

  switch $command
  case rehash shell
    set -e argv[1]
    command goenv sh-$command $argv | source
  case '*'
    command goenv $argv
  end
end
