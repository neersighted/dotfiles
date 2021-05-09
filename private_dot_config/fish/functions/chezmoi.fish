command -q chezmoi; or exit

function chezmoi
  switch $argv[1]
  case cd
    cd (chezmoi source-path)
  case edit
    if test (count $argv) -eq 1
      if set targets (chezmoi managed --include=files \
        | fzf --multi --preview 'bat --style=numbers --color=always ~/{}')
        set args '~/'$targets
        commandline --replace "chezmoi edit $args"
      end
    else
      command chezmoi $argv
    end
  case add
    if test (count $argv) -eq 1
      if set modified (chezmoi status \
        | string match -re '^.M|^M.' | string sub --start 4 \
        | fzf --multi --preview 'chezmoi diff --color=true ~/{}')
        set args '~/'$modified
        commandline --replace "chezmoi add $args"
      end
    else
      command chezmoi $argv
    end
  case '*'
    command chezmoi $argv
  end
end
