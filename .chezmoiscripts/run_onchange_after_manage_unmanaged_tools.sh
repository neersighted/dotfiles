#!/bin/sh -e

cd "${XDG_BIN_HOME:-$HOME/.local/bin}"

if [ -f "./chezmoi" ] && [ "$(which -a chezmoi | wc -l)" -gt 1 ]; then
  echo "Switching to system-managed chezmoi..."
  rm -f "./chezmoi"
fi

if ! command -v eget >/dev/null; then
  if [ "$(uname -s)" = Darwin ] && [ "$(uname -m)" = arm64 ]; then
    export GETEGET_PLATFORM='darwin_amd64'
  fi

  echo "Fetching eget binary..."
  curl https://zyedidia.github.io/eget.sh | sh
fi

if ! command -v vim-startuptime >/dev/null; then
  echo "Fetching vim-startuptime binary..."
  ./eget rhysd/vim-startuptime
fi

if ! command -v xurls >/dev/null; then
  echo "Fetching xurls binary..."
  ./eget mvdan/xurls
fi
