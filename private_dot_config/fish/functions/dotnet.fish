function dotnet
  set operation $argv[1..2]

  switch "$operation"
  case 'tool install' 'tool uninstall' 'tool update' 'tool list'
    set -e argv[1..2]

    command dotnet $operation --tool-path "$DOTNET_TOOL_PATH" $argv
  case '*'
    command dotnet $argv
  end
end
