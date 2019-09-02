set -g tty (tty)

# ssh/gpg startup
if status is-login; and not is_ssh
  __gpg-agent_auto_start $tty
end

# tmux/X startup
if not set -q DISPLAY; and string match -rq '^/dev/tty(1|v0)$' $tty
  # start i3 if installed (first tty only)
  command -sq startx; and command -sq i3; and exec startx $XDG_CONFIG_HOME/xinit/i3
else if not is_nvim
  __tmux_auto_launch $tty
end
