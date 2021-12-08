is_wsl; or exit

set -l aliases \
  adb \
  clion \
  cmd \
  goland \
  idea \
  multipass \
  neovide \
  powershell \
  pycharm \
  rider \
  studio \
  wsl \
  ykman
set -l alias_commands \
  "adb.exe" \
  "cmd.exe /c clion.cmd" \
  "cmd.exe" \
  "cmd.exe /c golang.cmd" \
  "cmd.exe /c idea.cmd" \
  "multipass.exe" \
  "neovide.exe --wsl" \
  "powershell.exe" \
  "cmd /c pycharm.cmd" \
  "cmd /c Rider.cmd" \
  "cmd /c studio.cmd" \
  "wsl.exe" \
  "ykman.exe"

while count $aliases >/dev/null
  set -l alias $aliases[1]; set -e aliases[1]
  set -l command (string split ' ' $alias_commands[1]); set -e alias_commands[1]

  # don't alias on top of native programs
  command -q $alias; and continue

  printf 'function %s -d "wsl wrapper for %s" -w %s; %s $argv; end' \
     $alias $command[1] $command[1] "$command" \
 | source
end
