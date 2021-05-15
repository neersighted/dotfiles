#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

case $(uname) in
  Darwin)
    section "System (Homebrew)"

    important "Upgrading packages with Homebrew..."
    brew upgrade
    important "Installing packages with Homebrew Bundle..."
    brew bundle
    ;;
  FreeBSD)
    [ "$(id -u)" -eq 0 ] || exec su root -c "sh $0"

    section "System (ports)"

    important "Upgrading ports with pkg..."
    pkg upgrade -y
    important "Installing ports with pkg..."
    sed 's/[[:space:]]*#.*//;/^[[:space:]]*$/d' \
      "$XDG_CONFIG_HOME/replicator/freebsd-ports.txt" | \
    xargs pkg install -y

    if ! grep -Eq '^CONSERVATIVE_UPGRADE' /usr/local/etc/pkg.conf; then
      important "Configuring pkg to upgrade aggressively..."
      printf '\n%s' 'CONSERVATIVE_UPGRADE: false;' >>/usr/local/etc/pkg.conf
    fi

    if ! grep -Eq '^PKG_ENABLE_PLUGINS' /usr/local/etc/pkg.conf; then
      important "Enabling pkg-provides..."
      sed -e '/PKG_PLUGINS_DIR/s/^#//' -e '/PKG_ENABLE_PLUGINS/s/^#//' \
        -e 's/#PLUGINS \[/PLUGINS [ provides ]/' -i '' /usr/local/etc/pkg.conf
    fi
    ;;
  Linux)
    section "System (pacman)"

    # bootstrap yay
    if ! command -v yay >/dev/null; then
      (
        important "Bootstrapping yay..."

        YAY="${TMPDIR:-/tmp}/yay"
        trap 'rm -rf $YAY' EXIT

        git clone https://aur.archlinux.org/yay.git "$YAY"
        cd "$YAY"
        makepkg -si --noconfirm
      )
    fi

    # pass through language managers
    export GOENV_VERSION=system NODENV_VERSION=system PYENV_VERSION=system RBENV_VERSION=system

    important "Upgrading packages with Yay..."
    yay -Syu --noconfirm
    important "Installing packages with Yay..."
    sed 's/[[:space:]]*#.*//;/^[[:space:]]*$/d' \
      "$XDG_CONFIG_HOME/replicator/arch-packages.txt" | \
    yay -S --needed --noconfirm
    important "Updating pacman file database..."
    yay -Fy
    ;;
esac

# vi: ft=sh
