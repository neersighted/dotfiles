status is-interactive; or exit

function __venv_auto_activate --on-variable PWD
  if status is-command-substitution
    return
  end

  __pyenv_virtualenv_activate
  __poetry_shell_activate
end

function __pyenv_virtualenv_activate
  # signal the plugin that we have loaded (and disable outdated prompt support)
  set -x PYENV_VIRTUALENV_INIT 1
  set -x PYENV_VIRTUALENV_DISABLE_PROMPT 1
  set -x PYENV_VIRTUALENV_VERBOSE_ACTIVATE 1

  if not set -q VIRTUAL_ENV; and set version_file (upcate .python-version)
    read version < $version_file

    if string match -rq 'envs/'$version'$' (builtin realpath $PYENV_ROOT/versions/$version)
      pyenv activate
      and set -g __pyenv_virtualenv $path
    end
  else if set -q __pyenv_virtualenv; and not string match -q "$__pyenv_virtualenv/*" $PWD/
    pyenv deactivate
    set -e __pyenv_virtualenv
  end
end

function __poetry_shell_activate
  # disable built-in venv prompt
  set -x VIRTUAL_ENV_DISABLE_PROMPT 1

  if not set -q POETRY_ACTIVE; and set pyproject (upcate pyproject.toml); and string match -q '[tool.poetry]' < $pyproject
    if set path (string replace -r '^(.+)/[^/]+$' '$1' $pyproject); and test -e $path/.venv; or poetry env info --path >/dev/null
      set -x __poetry_shell_initial $path
      poetry shell

      if set -qU __poetry_shell_final
        cd $__poetry_shell_final
        set -a dirprev $__poetry_shell_dirprev

        set -eU __poetry_shell_final
        set -eU __poetry_shell_dirprev
      end
    end
  else if set -qx __poetry_shell_initial; and not string match -q "$__poetry_shell_initial/*" $PWD/
    if not set -qU __poetry_shell_final
      set -U __poetry_shell_final $PWD
      set -U __poetry_shell_dirprev $dirprev
      exit
    end
  end
end
