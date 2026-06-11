status is-interactive; or exit

# shared history, but you can press up+enter for the last command
# alternatively, an empty command will force a sync
function __histsync --on-event histsync
  test -z "$fish_private_mode"; or return
  history save
  history merge
end
