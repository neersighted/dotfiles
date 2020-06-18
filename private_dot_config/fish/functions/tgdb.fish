function tgdb -d 'tmux-enabled gdb'
  if set -qx INNER
    set dashboard_pane (tmux split-window -PF '#{pane_id}|#{pane_tty}' -bh -l 120 -d -- 'exec disowntty' | string split '|')
    set inferior_pane (tmux split-window -PF '#{pane_id}|#{pane_tty}' -bv -l 50% -d -- 'exec disowntty' | string split '|')
    set shell_pane (tmux split-window -PF '#{pane_id}' -v -d)

    gdb -x $XDG_CONFIG_HOME/tgdb/gdbinit -tty $inferior_pane[2] -ex 'dashboard -output '$dashboard_pane[2] -ex 'start' -quiet $argv

    tmux kill-pane -t $dashboard_pane[1]
    tmux kill-pane -t $inferior_pane[1]
    tmux kill-pane -t $shell_pane
  else
    is_tmux; and set cmd new-window; or set cmd new
    tmux $cmd -n tgdb -e INNER=1 -- tgdb $argv
  end
end
