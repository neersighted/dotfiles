is_wsl; or exit

set -l aliases \
  multipass \
  neovide \
  ykman
set -l alias_commands \
  "multipass.exe" \
  "neovide.exe --wsl" \
  "ykman.exe"

while count $aliases >/dev/null
  alias $aliases[1] $alias_commands[1]
  set -e aliases[1]; set -e alias_commands[1] # FIXME: old fish can't erase two variables in one command
end
