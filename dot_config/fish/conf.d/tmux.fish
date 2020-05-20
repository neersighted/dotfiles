function tmux_session_name -a tty
  if is_ssh
    # is a remote login
    printf '%s-%s' (prompt_hostname) (string replace -a '.' '-' (string split ' ' $SSH_CONNECTION)[1])
  else if not is_tmux
    if not string match -rq '^/dev/(pts/\d+|ttys\d+)$' $tty; and not is_wsl1
      # is a console/tty
      printf '%s' $tty
    else
      # is a terminal/pty
      printf '%s' (prompt_hostname)
    end
  else
    # no nested tmux
    return 1
  end
end

function tmux_auto_launch -a tty
  set session (tmux_session_name $tty); or return

  if string match -q "$session 0" (tmux list-sessions -F '#{session_name} #{session_attached}' 2>/dev/null)
    # attach to unattached session
    set command attach-session -t $session \; run-shell 'pkill -USR1 -P #{pid} fish'
  else if not tmux has-session -t $session &>/dev/null
    # create non-existant setting
    set command new-session -s $session
  else
    # session exists and is attached
    return
  end

  tmux $command
end

if status is-interactive
  # run code on tmux reattach (signalled above)
  function tmux_resync --on-signal USR1
    if is_tmux
      # sync variables defined in tmux's update-environment array
      for entry in (tmux show-environment)
        if string match -rq '^-' -- $entry
          set -eg (string replace '-' '' -- $entry)
        else
          set var (string split '=' $entry)
          set -gx $var[1] $var[2]
        end
      end
    else
      # default is to exit on USR1, which we do when not in TMUX
      exit
    end
  end
end
