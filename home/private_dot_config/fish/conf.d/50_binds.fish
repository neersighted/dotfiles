function __bind_keys_startup --on-event fish_startup
  functions -e (status current-function)

  bind ! history-prev-command
  bind \$ history-prev-arguments

  bind alt-r push-line

  bind alt-z zoxide-interactive
  bind alt-x tmux-select
  bind alt-g fzf-git-switch

  fzf_configure_bindings \
    --directory=ctrl-o \
    --git_log=ctrl-g \
    --git_status=ctrl-alt-s \
    --history=ctrl-r \
    --processes=ctrl-alt-p \
    --variables=alt-v
end
