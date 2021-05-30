function tgdb -d 'tmux-enabled gdb(-dashboard)'
  if set -qx INNER
    set inferior_tty (tmux split-window -d -PF '#{pane_tty}' -bh -- 'exec disowntty')
    set dashboard_tty (tmux split-window -d -PF '#{pane_tty}' -bv -l 66% -t '{right}' -- 'exec disowntty')
    set source_tty (tmux split-window -d -PF '#{pane_tty}' -bv -l 66% -t '{left}' -- 'exec disowntty')
    set assembly_tty (tmux split-window -d -PF '#{pane_tty}' -bv -t '{top-left}' -- 'exec disowntty')

    gdb -x $XDG_CONFIG_HOME/tgdb/gdbinit \
       -tty $inferior_tty \
       -ex "dashboard -output $dashboard_tty" \
       -ex "dashboard source -output $source_tty" \
       -ex "dashboard assembly -output $assembly_tty" \
       -ex 'start' -quiet $argv

    for pid in (tmux list-panes -F '#{pane_pid}' -f "#{!=:#{pane_pid},$fish_pid}")
      kill $pid
    end
  else
    is_tmux; and set cmd new-window; or set cmd new-session
    tmux $cmd -n tgdb -e INNER=1 -- tgdb $argv
  end
end
