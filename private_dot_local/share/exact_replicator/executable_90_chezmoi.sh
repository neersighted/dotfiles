set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Chezmoi"

if [ "$(dirname "$(command -v chezmoi)")" = "$HOME/.local/bin" ]; then
  if [ "$(which -a chezmoi | wc -l)" -gt 1 ]; then
    important "Switching to system-managed chezmoi..."
    rm "$HOME/.local/bin/chezmoi"
  else
    important "Self-updating bootstrapped chezmoi..."
    "$HOME/.local/bin/chezmoi" upgrade
  fi
fi
