status is-interactive; and command -q direnv; or exit

function __direnv_export_eval --on-variable PWD
  direnv export fish | source
end

function __direnv_export_eval_startup --on-event fish_startup
  __direnv_export_eval
end
