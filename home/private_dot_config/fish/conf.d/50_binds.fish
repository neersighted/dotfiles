function __bind_keys_startup --on-event fish_startup
  functions -e (status current-function)

  bind enter execute-or-preexec

  bind ! history-prev-command
  bind \$ history-prev-arguments

  bind alt-r push-line

  bind alt-x tmux-select
  bind alt-z zoxide-interactive

  fzf_configure_bindings --directory=ctrl-o --variables=alt-v
  bind alt-g fzf-git-switch
  bind ctrl-g fzf-git-commit
end
