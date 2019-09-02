set -g tty (tty)

# ssh/gpg startup
if status is-login; and not ssh?
  __gpg-agent_auto_start $tty
end

# tmux/X startup
if not set -q DISPLAY; and command -sq startx; and string match -rq '^/dev/tty(1|v0)$' $tty
  # start i3 if installed (first tty only)
  command -sq i3; and exec startx $XDG_CONFIG_HOME/xinit/i3
else if not nvim?
  __tmux_auto_launch $tty
end
