function __bind_keys --on-event fish_startup
  bind \r execute-or-preexec

  bind ! history-prev-command
  bind \$ history-prev-arguments

  bind \er push-line

  bind \ex tmx
  bind \ez fzfz

  fzf_configure_bindings --directory=\co --variables=\ev
  bind \cg fzf-git-recent-branch

  functions -e __bind_keys
end
