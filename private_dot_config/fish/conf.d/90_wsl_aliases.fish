is_wsl; or exit

set -l aliases \
  cmd \
  multipass \
  neovide \
  powershell \
  wsl \
  ykman
set -l alias_commands \
  "cmd.exe" \
  "multipass.exe" \
  "neovide.exe --wsl" \
  "powershell.exe" \
  "wsl.exe" \
  "ykman.exe"

while count $aliases >/dev/null
  set -l alias $aliases[1]; set -e aliases[1]
  set -l command (string split ' ' $alias_commands[1]); set -e alias_commands[1]

  printf 'function %s -d "wsl wrapper for %s" -w %s; %s $argv; end' \
     $alias $command[1] $command[1] "$command" \
 | source
end
