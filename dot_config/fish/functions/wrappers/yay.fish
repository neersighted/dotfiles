if command -q yay
  function yay
    set -lx GOENV_VERSION system
    set -lx NODENV_VERSION system
    set -lx PYENV_VERSION system
    set -lx RBENV_VERSION system

    command yay $argv
  end
end
