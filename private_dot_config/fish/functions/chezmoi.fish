command -q chezmoi; or exit

function chezmoi
  switch $argv[1]
  case cd
    cd (chezmoi source-path)
  case edit
    if test (count $argv) -eq 1
      if set targets (chezmoi managed --include=files | fzf --multi)
        chezmoi edit ~/$targets
      end
    else
      command chezmoi $argv
    end
  case '*'
    command chezmoi $argv
  end
end
