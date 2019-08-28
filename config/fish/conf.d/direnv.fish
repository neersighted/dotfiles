status is-interactive; or exit

function __direnv_export_eval --on-variable PWD
  if status is-command-substitution
    return
  end

  direnv export fish | source
end
