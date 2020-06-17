#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

getshell() { # shell
  case $(uname) in
    Darwin)
      dscl . read "/Users/$USER" UserShell | awk '{print $2}'
      ;;
    *)
      getent passwd "$USER" | awk -F: '{print $7}'
      ;;
  esac
}

setshell() { # shell
  case $(uname) in
    Darwin)
      sudo dscl . create "/Users/$USER" UserShell "$1"
      ;;
    FreeBSD)
      su root -c "pw usermod -n '$USER' -s '$1'"
      ;;
    *)
      sudo usermod -s "$1" "$USER"
      ;;
  esac
}

section "fish"

fish=$(command -v fish)
if [ "$(getshell)" != "$fish" ]; then

  if ! grep -Fxq "$fish" /etc/shells; then
    info "Adding $fish to /etc/shells..."
    printf '%s\n' "$fish" | sudo tee -a /etc/shells
  fi

  important "Changing login shell to fish..."
  setshell "$fish"
fi

if [ -f "$XDG_CONFIG_HOME/fish/functions/fisher.fish" ]; then
  important "Syncing fish plugins..."
  fish -c "fisher self-update; and fisher"
fi

# vi: ft=sh