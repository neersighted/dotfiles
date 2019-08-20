status is-interactive; or exit

# use $XDG_CONFIG_HOME for tmux.conf
function tmux
  command tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf $argv
end

# re-synchronize update-environment variables on attach
function __tmux_resync --on-signal USR1
  if set -q TMUX
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
