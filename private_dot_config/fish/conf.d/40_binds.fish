status is-interactive; or exit

function __bind_keys --on-event fish_startup
  bind \r repaint-and-execute
  bind \n repaint-and-execute

  bind ! history-prev-command
  bind \$ history-prev-arguments

  bind \er push-line

  bind \ex tmx
  bind \ez fzfz

  fzf_configure_bindings --directory=\co --variables=\ev
  bind \eg fzf-git-recent-branch

  functions -e __bind_keys
end
