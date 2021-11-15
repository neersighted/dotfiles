#!/bin/sh -e

export NUGET_PACKAGES="${NUGET_PACKAGES:-${XDG_DATA_HOME:-$HOME/.local/share}/nuget}"
export DOTNET_ROOT="${DOTNET_ROOT:-${XDG_DATA_HOME:-$HOME/.local/share}/dotnet}"
export DOTNET_TOOL_PATH="${DOTNET_TOOL_PATH:-$DOTNET_ROOT/tools}"
export PATH="$DOTNET_TOOL_PATH:$DOTNET_ROOT:$PATH"

if [ ! -x "$DOTNET_ROOT/dotnet" ]; then
  echo "Downloading .NET SDK..."
  export DOTNET_INSTALL_DIR="$DOTNET_ROOT"
  curl -sS https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh | bash -s -- --no-path --channel Current
fi

for tool in installsdkglobaltool; do
  test -d "$DOTNET_TOOL_PATH/.store/$tool" || wanted="$tool $wanted"
done
if [ -n "$wanted" ]; then
  echo "Installing .NET tools..."
  for tool in $wanted; do
    dotnet tool install --tool-path "$DOTNET_TOOL_PATH" "$tool"
  done
fi

# FIXME: dotnet arrow key bug
tput rmkx

# vi: ft=sh
