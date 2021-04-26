command -q pyenv; or exit

function pyenv -d 'python environment manager'
  set command $argv[1]

  switch "$command"
  case activate deactivate rehash shell
    set -e argv[1]
    command pyenv sh-$command $argv | source
  case '*'
    command pyenv $argv
  end
end
