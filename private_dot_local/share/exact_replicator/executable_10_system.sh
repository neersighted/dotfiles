#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "System Packages"

case $(uname) in
  Darwin)
    important "Installing packages with Homebrew Bundle..."
    brew bundle
    ;;
  FreeBSD)
    important "Installing ports with pkg..."
    # pkg install
    # pkg provides -u

    if ! grep -Eq '^CONSERVATIVE_UPGRADE' /usr/local/etc/pkg.conf; then
      important "Configuring pkg to upgrade aggressively..."
      printf '\n%s' 'CONSERVATIVE_UPGRADE: false;' >>/usr/local/etc/pkg.conf
    fi

    if ! grep -Eq '^PKG_ENABLE_PLUGINS' /usr/local/etc/pkg.conf; then
      important "Enabling pkg-provides..."
      sed -e '/PKG_PLUGINS_DIR/s/^#//' -e '/PKG_ENABLE_PLUGINS/s/^#//' -e 's/#PLUGINS \[/PLUGINS [ provides ]/' -i '' /usr/local/etc/pkg.conf
    fi
    ;;
  Linux)
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

    # yay -Syu
    # yay -Fy
    ;;
esac

# vi: ft=sh
