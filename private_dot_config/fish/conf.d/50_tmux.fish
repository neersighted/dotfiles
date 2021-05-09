command -q tmux; or exit

# run code on tmux reattach (signaled below)
function __tmux_resync --on-signal USR1
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

function __tmux_session_name
  if is_ssh
    # is a remote login
    printf '%s-%s' (prompt_hostname) (string replace -a '.' '-' (string split ' ' $SSH_CONNECTION)[1])
  else if not is_tmux; and not is_editor
    if not string match -rq '^/dev/(pts/\d+|ttys\d+)$' $tty; and not is_wsl1
      # is a console/tty
      printf '%s' $tty
    else
      # is a terminal/pty
      printf '%s' (prompt_hostname)
    end
  else
    # no nested tmux/tmux in editor
    return 1
  end
end

function __tmux_auto_launch --on-event fish_startup
  status is-interactive; or return
  set session (__tmux_session_name); or return

  if not tmux has-session -t $session &>/dev/null
    tmux new -s $session
  else if test -z (tmux list-clients -t $session)[1]
    tmux attach -t $session \; run-shell 'pkill -USR1 -P #{pid} fish'
  end
end
