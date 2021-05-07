command -q chezmoi; or exit

function chezmoi
  switch $argv[1]
  case cd
    cd (chezmoi source-path)
  case '*'
    command chezmoi $argv
  end
end
