function fish_title
  set -q argv[1]; or set argv 'fish'

  if test "$PWD" = "$HOME"
    set pwd $HOME
  else
    set pwd (prompt_pwd)
  end

  printf '%s: %s' (string trim $argv) $pwd
end
