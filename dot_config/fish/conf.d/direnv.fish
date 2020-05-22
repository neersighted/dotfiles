status is-interactive; or exit

function __direnv_export_eval --on-variable PWD
  direnv export fish | source
end

function __direnv_export_eval_startup --on-event fish_prompt
  __direnv_export_eval
  functions --erase (status current-function)
end
