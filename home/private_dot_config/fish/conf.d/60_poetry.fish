status is-interactive; or exit

# --on-variable PWD doesn't fire at startup
function __poetry_auto_activate_startup --on-event fish_startup
  functions -e (status current-function)
  __poetry_auto_activate
end

function __poetry_auto_activate --on-variable PWD
  status is-command-substitution; and return

  if not set -q VIRTUAL_ENV; and set pyproject (upcate pyproject.toml); and string match -q '[tool.poetry]' < $pyproject
    set project (path dirname $pyproject)
    set venv (poetry env info --path); or set venv $project/.venv

    if test -e $venv
      source "$venv/bin/activate.fish"
      and set -g __poetry_project $project
    end
  else if set -q __poetry_project; and not string match -q "$__poetry_project/*" $PWD/
      functions -q deactivate; and deactivate
      set -e __poetry_project
  end
end
