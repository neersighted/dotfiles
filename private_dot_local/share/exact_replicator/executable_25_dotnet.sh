#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section ".NET"

if [ ! -d "$DOTNET_ROOT" ]; then
  important "Fetching .NET SDK..."
  export DOTNET_INSTALL_DIR=$DOTNET_ROOT
  curl -sS https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh | bash -s -- --no-path --channel Current
fi

dotnet_tool_install installsdkglobaltool

# vi: ft=sh
