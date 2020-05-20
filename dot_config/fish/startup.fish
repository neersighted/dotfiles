# tmux/X startup
if not set -q DISPLAY; and string match -rq '^/dev/tty(1|v0)$' $tty
  # start i3 if installed (first tty only)
  command -q startx; and command -q i3; and exec startx $XDG_CONFIG_HOME/xinit/i3
else if not is_nvim
  tmux_auto_launch $tty
end
