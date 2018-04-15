#!/bin/sh

# Default to i3.
export DESKTOP_SESSION=${1:-i3}
# Assume X11 by default.
export XDG_SESSION_TYPE=${XDG_SESSION_TYPE:-x11}

# Load profile.
for f in "/etc/profile" "$HOME/.profile" "/etc/xprofile" "$HOME/.xprofile" "$HOME/.xprofile.local"; do
  test -f "$f" && . "$f"
done

# Load resources.
for f in "/etc/X11/Xresources" "/usr/local/etc/X11/.Xresources" "$HOME/.Xresources"; do
  test -f "$f" && xrdb -merge "$f"
done

# Load keymaps.
for f in "/etc/X11/Xkbmap" "/usr/local/etc/X11/.Xkbmap" "$HOME/.Xkbmap"; do
  test -f "$f" && setxkbmap < "$f"
done
for f in "/etc/X11/Xmodmap" "/usr/local/etc/X11/.Xmodmap" "$HOME/.Xmodmap"; do
  test -f "$f" && xmodmap "$f"
done

# Load global config.
for d in "/etc/X11/xinit/xinitrc.d" "/usr/local/etc/X11/xinitrc.d"; do
  if test -d "$d"; then
    for f in "$d/?*.sh"; do
      test -x "$f" && . "$f"
    done
  fi
done

# Load user config.
for f in "$HOME/.xsession" "$HOME/.xsession.local"; do
  test -f "$f" && . "$f"
done

case $DESKTOP_SESSION in
  i3 ) exec i3;;
  *  ) exec "$DESKTOP_SESSION";;
esac
