status is-login; or test "$SHLVL" -eq 1; or exit

function __housekeeping --on-event fish_startup
  set -l __housekeeping_latest (chezmoi git rev-parse HEAD)
  test "$__housekeeping_latest" != "$housekeeping_last"; or return

  rm -f $HOME/.gitconfig

  set -U __housekeeping_last $__housekeeping_latest
end
