status is-interactive; or exit

# shared history, but you can press up+enter for the last command
# alternatively, an empty command will force a sync
function __histsync --on-event fish_preexec
  history save
  history merge
end
