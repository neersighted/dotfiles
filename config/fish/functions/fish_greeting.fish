function fish_greeting --description 'prints a greeting'
  if status --is-login; and type -q fortune
    if type -q cowsay
      fortune -a | cowsay
    else
      fortune -a
    end
  end
end
