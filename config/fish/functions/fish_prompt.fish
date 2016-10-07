
function fish_prompt --description 'left prompt'
  set prompt "λ "

  if test -n "$SSH_CLIENT"; or test -n "$SSH_TTY"
    set prompt (hostname)" $prompt"
  end

  echo -n -s "$prompt"
end
