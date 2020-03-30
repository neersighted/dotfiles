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

function nvim
  if set -q NVIM_LISTEN_ADDRESS; and test -S $NVIM_LISTEN_ADDRESS
    if is_tmux; and set -l editor_pane (tmux list-panes -F '#{pane_id} #{pane_current_command}' | string match -r '^(%\d+) nvim')[2]
      tmux select-pane -t $editor_pane
    end

    if not socat -u OPEN:/dev/null UNIX-CONNECT:$NVIM_LISTEN_ADDRESS &>/dev/null
      rm -f $NVIM_LISTEN_ADDRESS
    end

    command nvr -s $argv
  else
    command nvim $argv
  end
end
