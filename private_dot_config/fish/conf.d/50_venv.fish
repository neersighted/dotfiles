status is-interactive; or exit

function __venv_auto_activate --on-variable PWD
  if status is-command-substitution
    return
  end

  __poetry_project_activate
end

function __venv_auto_activate_startup --on-event fish_prompt
  functions -e __venv_auto_activate_startup

  __venv_auto_activate
end

function __poetry_project_activate
  # disable built-in venv prompt
  set -x VIRTUAL_ENV_DISABLE_PROMPT 1

  if not set -q VIRTUAL_ENV; and set pyproject (upcate pyproject.toml); and string match -q '[tool.poetry]' < $pyproject
    set project (string replace -r '^(.+)/[^/]+$' '$1' $pyproject)
    set venv (poetry env info --path; or $path/.venv)

    if test -e $venv
      source "$venv/bin/activate.fish"
      and set -g __poetry_project $project
    end
  else if set -q __poetry_project; and not string match -q "$__poetry_project/*" $PWD/
      deactivate
      set -e __poetry_project
  end
end
