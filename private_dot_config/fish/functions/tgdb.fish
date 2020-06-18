function tgdb -d 'tmux-enabled gdb'
  if set -qx INNER
    set dashboard_pane (tmux split-window -PF '#{pane_id}|#{pane_tty}' -bh -d -t $TMUX_PANE -- 'exec disowntty' | string split '|')
    set assembly_pane (tmux split-window -PF '#{pane_id}|#{pane_tty}' -bv -d -t $dashboard_pane[1] -- 'exec disowntty' | string split '|')
    set source_pane (tmux split-window -PF '#{pane_id}|#{pane_tty}' -v -d -t $assembly_pane[1] -- 'exec disowntty' | string split '|')
    set inferior_pane (tmux split-window -PF '#{pane_id}|#{pane_tty}' -bv -l 25% -d -t $TMUX_PANE -- 'exec disowntty' | string split '|')
    set shell_pane (tmux split-window -PF '#{pane_id}' -v -d -t $TMUX_PANE)

    gdb -x $XDG_CONFIG_HOME/tgdb/gdbinit -tty $inferior_pane[2] -ex 'dashboard -output '$dashboard_pane[2] -ex 'dashboard assembly -output '$assembly_pane[2] -ex 'dashboard source -output '$source_pane[2] -ex 'start' -quiet $argv

    tmux kill-pane -t $dashboard_pane[1]
    tmux kill-pane -t $assembly_pane[1]
    tmux kill-pane -t $source_pane[1]
    tmux kill-pane -t $inferior_pane[1]
    tmux kill-pane -t $shell_pane
  else
    is_tmux; and set cmd new-window; or set cmd new
    tmux $cmd -n tgdb -e INNER=1 -- tgdb $argv
  end
end
