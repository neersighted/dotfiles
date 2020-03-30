status is-interactive; or exit

# use $XDG_CONFIG_HOME for tmux.conf
function tmux
  command tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf $argv
end

function __tmux_session_name -a tty
  test -n "$tty"; or set tty (tty)

  if is_vscode # special terminals
     printf '%s' $TERM_PROGRAM
  else if is_ssh
    printf '%s-%s' (prompt_hostname) (string replace -a '.' '-' (string split ' ' $SSH_CONNECTION)[1])
  else if not is_tmux
    if not string match -rq '^/dev/(pts/\d+|ttys\d+)$' $tty; and not is_wsl
      printf '%s' $tty
    else
      printf '%s' (prompt_hostname)
    end
  else # no nested tmux
    return 1
  end
end

function __tmux_auto_launch -a tty
  set session (__tmux_session_name $tty); or return

  if string match -q "$session 0" (tmux list-sessions -F '#{session_name} #{session_attached}' 2>/dev/null)
    # attach to unattached session
    set command attach-session -t $session \; run-shell 'pkill -USR1 -P #{pid} fish'
  else if not tmux has-session -t $session &>/dev/null
    # create non-existant setting
    set command new-session -s $session
  else
    return
  end

  tmux $command
end

# re-synchronize update-environment variables on attach
function __tmux_resync --on-signal USR1
  if is_tmux
    for entry in (tmux show-environment)
      if string match -rq '^-' -- $entry
        set -l envvar (string replace '-' '' -- $entry)
        set -eg $envvar
      else
        set -l envpair (string split '=' $entry)
        set -gx $envpair[1] $envpair[2]
      end
    end
  else
    exit
  end
end
