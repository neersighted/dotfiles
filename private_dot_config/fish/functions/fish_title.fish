function fish_title
  set -q argv[1]; or set argv 'fish'

  if is_ssh
    printf '(%s) ' (prompt_hostname)
  end

  if test "$PWD" = "$HOME"
    set pwd $HOME
  else
    set pwd (prompt_pwd)
  end

  printf '%s: %s' $pwd $argv
end
