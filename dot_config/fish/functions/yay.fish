command -q yay; or exit

function yay
  set -x GOENV_VERSION system
  set -x NODENV_VERSION system
  set -x PYENV_VERSION system
  set -x RBENV_VERSION system

  command yay $argv
end
