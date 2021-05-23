function tgdb -d 'tmux-enabled gdb'
  if set -qx INNER
    set dashboard_tty (tmux split-window -PF '#{pane_tty}' -bh -d -- 'exec disowntty')
    set inferior_tty (tmux split-window -PF '#{pane_tty}' -v -l 34% -d -t '{left}' -- 'exec disowntty')
    set source_tty (tmux split-window -PF '#{pane_tty}' -bv -l 66% -d -- 'exec disowntty')
    set assembly_tty (tmux split-window -PF '#{pane_tty}' -bv -d -t '{top-right}' -- 'exec disowntty')

    gdb -x $XDG_CONFIG_HOME/tgdb/gdbinit -tty $inferior_tty -ex 'dashboard -output '$dashboard_tty -ex 'dashboard source -output '$source_tty -ex 'dashboard assembly -output '$assembly_tty -ex 'start' -quiet $argv

    tmux kill-window
  else
    is_tmux; and set cmd new-window; or set cmd new
    tmux $cmd -n tgdb -e INNER=1 -- tgdb $argv
  end
end
