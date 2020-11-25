#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

UNAME="$(uname)"

case "$UNAME" in
  Linux)
    PKGS="arch-packages.txt"
    INSTALL_CMD="yay -Sy --noconfirm"
    UPDATE_CMD="yay -Syu --noconfirm"
    PROVIDES_CMD="yay -Fy"
    INSTALLED_LIST=$(pacman -Qq)
    ;;
  FreeBSD)
    [ "$(id -u)" -eq 0 ] || exec su root -c "sh $0"

    PKGS="freebsd-ports.txt"
    INSTALL_CMD="pkg install -y"
    UPDATE_CMD="pkg upgrade -y"
    PROVIDES_CMD="pkg provides -u"
    INSTALLED_LIST=$(pkg query '%o')
    ;;
  Darwin)
    PKGS="homebrew-formulae.txt"
    TAPS="homebrew-taps.txt"
    INSTALL_CMD="brew install"
    UPDATE_CMD="brew update; brew upgrade"
    INSTALLED_LIST=$(brew list --formula)
    TAPPED_LIST=$(brew tap)
    ;;
  *)
    error "Unsupported operating system."
    ;;
esac

section "System Packages"

while IFS= read -r line; do
  if [ -z "$line" ] || printf '%s' "$line" | grep -Eq '^#'; then
    continue
  fi

  if [ "$UNAME" = 'FreeBSD' ] && printf '%s' "$line" | grep -Fq '@'; then
    origin=$(printf '%s' "$line" | cut -d@ -f1)
    flavor=$(printf '%s' "$line" | cut -d@ -f2)

    installed="$origin"
    install=$(pkg rquery -e "%o ~ $origin" '%n %At %Av' | grep -F "flavor $flavor" | cut -d' ' -f1 | head -n1)
  else
    installed="$line"
    install="$line"
  fi

  if ! printf '%s' "$INSTALLED_LIST" | grep -Fxq "$installed"; then
    INSTALL="$INSTALL$install "
  fi
done <"$XDG_CONFIG_HOME/replicator/$PKGS"

case "$UNAME" in
  Darwin)
    while IFS= read -r line; do
      tap=$(printf '%s' "$line" | cut -d' ' -f1)
      url=$(printf '%s' "$line" | cut -d' ' -f2)

      if ! printf '%s' "$TAPPED_LIST" | grep -Fxq "$tap"; then
        important "Tapping $tap..."
        brew tap "$tap" "${url:+$url}"
      fi
    done < "$XDG_CONFIG_HOME/replicator/$TAPS"
    ;;
  FreeBSD)
    if ! grep -Eq '^CONSERVATIVE_UPGRADE' /usr/local/etc/pkg.conf; then
      important "Configuring pkg to upgrade Aggressively..."
      printf '\n%s' 'CONSERVATIVE_UPGRADE: false;' >>/usr/local/etc/pkg.conf
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

    # add-in wslu
    if uname -a | grep -iq microsoft && ! command -v wslview >/dev/null; then
      INSTALL="${INSTALL}wslu"
    fi

    # pass through language managers
    export GOENV_VERSION=system NODENV_VERSION=system PYENV_VERSION=system RBENV_VERSION=system
    ;;
esac

if [ -n "$INSTALL" ]; then
  important "Installing system packages with ${INSTALL_CMD%% *}..."

  info "$INSTALL_CMD $INSTALL"
  eval "$INSTALL_CMD $INSTALL"
fi

important "Updating system packages with ${UPDATE_CMD%% *}..."
eval "$UPDATE_CMD"

if [ "$UNAME" = 'FreeBSD' ] && ! grep -Eq '^PKG_ENABLE_PLUGINS' /usr/local/etc/pkg.conf; then
  important "Enabling pkg-provides..."
  sed -e '/PKG_PLUGINS_DIR/s/^#//' -e '/PKG_ENABLE_PLUGINS/s/^#//' -e 's/#PLUGINS \[/PLUGINS [ provides ]/' -i '' /usr/local/etc/pkg.conf
fi

if [ -n "$PROVIDES_CMD" ]; then
  important "Updating provides database..."
  eval "$PROVIDES_CMD"
fi

# vi: ft=sh
