function nvim
  set -l wait 0
  if not status is-interactive; or status stack-trace | string match -rq "function 'edit_command_buffer'\$"
    set wait 1
  end

  if set -q NVIM_LISTEN_ADDRESS; and test -S $NVIM_LISTEN_ADDRESS
    if not socat -u OPEN:/dev/null UNIX-CONNECT:$NVIM_LISTEN_ADDRESS &>/dev/null
      rm -f $NVIM_LISTEN_ADDRESS
    end

    set -l this_pane
    set -l editor_pane

    if is_tmux
      set this_pane (tmux display-message -p '#{pane_id}')
      set editor_pane (tmux list-panes -F '#{pane_id} #{pane_current_command}' | string match -r '^(%\d+) nvim')[2]
      and tmux select-pane -t $editor_pane
    end

    if test $wait -eq 1
      command nvr -s --remote-wait-silent $argv
      set -l editor_status $status

      test -n "$this_pane"; and tmux select-pane -t $this_pane
      return $editor_status
    else
      command nvr -s $argv
    end
  else
    command nvim $argv
  end
end

status is-interactive; or exit

function __nvim_tmux_startup -e fish_prompt
  if is_tmux; and not is_nvim
    set -l tmpdir $TMPDIR/nvim-tmux
    set -l window_id (tmux display-message -p '#{window_id}')

    mkdir -p $tmpdir
    set -gx NVIM_LISTEN_ADDRESS $tmpdir/$USER$window_id.sock
  end

  functions -e __nvim_tmux_startup
end
