status --is-interactive; or exit

function __direnv_export_eval --on-variable PWD
  direnv export fish | source
end

function __pyenv_virtualenv_activate --on-variable PWD
  if status --is-command-substitution
    return
  end

  # signal the plugin that we have loaded (and disable outdated prompt support)
  set -gx PYENV_VIRTUALENV_INIT 1
  set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
  set -gx PYENV_VIRTUALENV_VERBOSE_ACTIVATE 1

  # don't override venvs activated through other methods
  if not set -q VIRTUAL_ENV
    # attempt to locate a .pyhon-version file
    if set -l path (upcate .python-version)
      read -l version < $path/.python-version

      # check that .python-version contans a venv
      if string match -rq 'envs/'$version'$' (builtin realpath $PYENV_ROOT/versions/$version)
        # activate the venv and record the location for later use
        pyenv activate
        and set -g __pyenv_virtualenv $path
      end
    end
  # if we auto-activated a venv, make sure we are still in the directory tree
  else if set -q __pyenv_virtualenv; and not string match -q $__pyenv_virtualenv/'*' $PWD/
    # if we left, deactivate
    pyenv deactivate
    set -e __pyenv_virtualenv
  end
end

function __pipenv_shell_activate --on-variable PWD
  if status --is-command-substitution
    return
  end

  # don't attempt nested activations
  if not set -q PIPENV_ACTIVE
    # attempt to locate a Pipfile and an extant venv
    if set -l path (upcate Pipfile); and test -e $path/.venv
      # start a subshell with knowledge of the Pipfile location
      set -lx __pipenv_shell_initial $path
      pipenv shell

      # if the subshell reported a new exit location, jump there
      if set -q __pipenv_shell_final
        cd $__pipenv_shell_final
        set -e __pipenv_shell_final
      end
    end
  # if we are in a subshell, make sure we are still in the directory tree
  else if set -q __pipenv_shell_initial; and not string match -q $__pipenv_shell_initial/'*' $PWD/
    # if we left, record the new path and return to the parent shell
    set -U __pipenv_shell_final $PWD
    exit
  end
end

