status is-interactive; or exit

# sync/share history on blank command; respects $fish_private_mode
function execute-or-histsync
  set -f commandline (commandline)
  if test -z "$commandline$fish_private_mode"
    history save
    history merge
  end
  commandline -f execute
end

bind enter execute-or-histsync
