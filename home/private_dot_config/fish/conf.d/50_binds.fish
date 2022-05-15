function __bind_keys --on-event fish_startup
  functions -e (status current-function)

  bind \r execute-or-preexec

  bind ! history-prev-command
  bind \$ history-prev-arguments

  bind \er push-line

  bind \ex tmux-select
  bind \ez zoxide-interactive

  fzf_configure_bindings --directory=\co --variables=\ev
  bind \cg fzf-git-recent-branch
end
