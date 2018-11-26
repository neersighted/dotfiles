# re-synchronize update-environment variables on attach
function __tmux_resync --on-signal USR1
  if set -qg TMUX
    for entry in (tmux show-environment | string match -r '^[^-].*')
      set -l envpair (string split '=' $entry)
      set -gx $envpair[1] $envpair[2]
    end
  else
    exit
  end
end
