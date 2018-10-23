function fish_greeting --description 'prints a greeting'
  if status --is-login; and command -sq fortune
    if command -sq cowsay
      fortune -a | cowsay
    else
      fortune -a
    end
  end
end
