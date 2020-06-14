function nvim
  if not status is-interactive; or status stack-trace | string match -rq "function 'edit_command_buffer'\$"
    set wait
    set -p argv --remote-wait-silent
  end

  if is_tmux; and not set -qx NVIM_LISTEN_ADDRESS
    set -l dir $XDG_RUNTIME_DIR/nvim-tmux
    test -d $dir; or mkdir $dir
    set -x NVIM_LISTEN_ADDRESS $dir/(tmux display-message -p '#{window_id}').sock
  end

  if set -q NVIM_LISTEN_ADDRESS
    if test -S $NVIM_LISTEN_ADDRESS; and not socat -u OPEN:/dev/null UNIX-CONNECT:$NVIM_LISTEN_ADDRESS &>/dev/null
      rm -f $NVIM_LISTEN_ADDRESS
    end

    if is_tmux
      set editor_pane (tmux list-panes -F '#{pane_id} #{pane_current_command}' | string match -r '^(%\d+) nvim')[2]
      or set editor_pane (tmux split-window -PF '#{pane_id}' -fhb -c $PWD -- nvim --listen $NVIM_LISTEN_ADDRESS)
      tmux select-pane -t $editor_pane
    end

    if not is_tmux; or test (count $argv) -gt 0
      nvr -s $argv
      set editor_status $status
    end

    if is_tmux; and set -q wait
      tmux select-pane -t $TMUX_PANE
    end

    return $editor_status
  else
    command nvim $argv
  end
end
