command -q dotnet; or exit

function dotnet
  set operation $argv[1..2]

  switch "$operation"
  case 'tool install' 'tool uninstall' 'tool update' 'tool list'
    set -e argv[1..2]

    if set i (contains -i -- '-g' $argv); or set i (contains -i -- '--global' $argv)
      set -e argv\[$i]
      set -p argv --tool-path "$DOTNET_TOOL_PATH"
    end

    command dotnet $operation $argv
  case '*'
    command dotnet $argv
  end

  # FIXME: dotnet arrow key bug
  tput rmkx
end
