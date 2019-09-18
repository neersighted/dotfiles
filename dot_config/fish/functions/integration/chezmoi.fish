function chezmoi
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case cd
    cd (chezmoi source-path)
  case '*'
    command chezmoi $command $argv
  end
end
