status is-interactive; or exit

function __direnv_export_eval --on-variable PWD
  direnv export fish | source
end

__direnv_export_eval
