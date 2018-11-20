function fish_greeting --description 'prints a greeting'
  if status --is-login; and not set -qg TMUX
    command -sq fortune; and fortune -a
  end
end
