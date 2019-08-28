status is-interactive; or exit

function __direnv_export_eval --on-variable PWD
  if status is-command-substitution
    return
  end

  direnv export fish | source
end

function __pyenv_virtualenv_activate --on-variable PWD
  if status is-command-substitution
    return
  end

  # signal the plugin that we have loaded (and disable outdated prompt support)
  set -gx PYENV_VIRTUALENV_INIT 1
  set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
  set -gx PYENV_VIRTUALENV_VERBOSE_ACTIVATE 1

  # don't override venvs activated through other methods
  if not set -q VIRTUAL_ENV
    # attempt to locate a .pyhon-version file
    if set version_file (upcate .python-version)
      read version < $version_file

      # check that .python-version contans a venv
      if string match -rq 'envs/'$version'$' (builtin realpath $PYENV_ROOT/versions/$version)
        # activate the venv and record the location for later use
        pyenv activate
        and set -g __pyenv_virtualenv $path
      end
    end
  # if we auto-activated a venv, make sure we are still in the directory tree
  else if set -q __pyenv_virtualenv; and not string match -q "$__pyenv_virtualenv/*" $PWD/
    # if we left, deactivate
    pyenv deactivate
    set -e __pyenv_virtualenv
  end
end

function __pipenv_shell_activate --on-variable PWD
  if status is-command-substitution
    return
  end

  # don't attempt nested activations
  if not set -q PIPENV_ACTIVE
    # attempt to locate a Pipfile and an extant venv
    if set path (upcate Pipfile | string replace -r '^(.+)/[^/]+$' '$1')
      if test -e $path/.venv; or pipenv --venv
        # start a subshell with knowledge of the Pipfile location
        set -x __pipenv_shell_initial $path
        pipenv shell --fancy

        # if the subshell reported a new exit location, jump there
        if set -q __pipenv_shell_final
          cd $__pipenv_shell_final
          set -e __pipenv_shell_final
        end
      end
    end
  # if we are in a subshell, make sure we are still in the directory tree
  else if set -q __pipenv_shell_initial; and not string match -q "$__pipenv_shell_initial/*" $PWD/
    # if we left, record the new path and return to the parent shell
    set -U __pipenv_shell_final $PWD
    exit
  end
end

function __poetry_shell_activate --on-variable PWD
  if status is-command-substitution
    return
  end

  # don't attempt nested activations
  if not set -q POETRY_ACTIVE
    # attempt to locate a pyproject.toml that uses poetry
    if set pyproject (upcate pyproject.toml); and string match -q '[tool.poetry]' < $pyproject
      if set path (string replace -r '^(.+)/[^/]+$' '$1' $pyproject); and test -e $path/.venv; or poetry env info --path >/dev/null
        # start a subshell with knowledge of the pyproject.toml location
        set -x __poetry_shell_initial $path
        poetry shell

        # if the subshell reported a new exit location, jump there
        if set -q __poetry_shell_final
          cd $__poetry_shell_final
          set -e __poetry_shell_final
        end
      end
    end
  # if we are in a subshell, make sure we are still in the directory tree
  else if set -q __poetry_shell_initial; and not string match -q "$__poetry_shell_initial/*" $PWD/
    # if we left, record the new path and return to the parent shell
    set -U __poetry_shell_final $PWD
    exit
  end
end
