function fish_right_prompt --description 'right prompt'
  set last_status $status

  set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)
  set_color normal

  if set -q prompt_minimal
    return
  end

  set -l context

  if set -q GOENV_VERSION; or set version_file (upcate .go-version)
    set -q GOENV_VERSION; or read GOENV_VERSION < $version_file

    set -l element (set_color $fish_color_golang)
    set -a element "go:$GOENV_VERSION"
    set -a element (set_color normal)
    set -a context (string join '' $element)
  end

  if set -q NODENV_VERSION; or set version_file (upcate .node-version)
    set -q NODENV_VERSION; or read NODENV_VERSION < $version_file

    set -l element (set_color $fish_color_nodejs)
    set -a element "js:$NODENV_VERSION"
    set -a element (set_color normal)
    set -a context (string join '' $element)
  end

  if set -q PYENV_VERSION; or set version_file (upcate .python-version)
    set -q PYENV_VERSION; or read PYENV_VERSION < $version_file

    set -l element (set_color $fish_color_python)
    set -a element "py:$PYENV_VERSION"
    set -a element (set_color normal)
    set -a context (string join '' $element)
  end

  if set -q VIRTUAL_ENV; and set venv_path (string split '/' $VIRTUAL_ENV)
    if not test $venv_path[-1] = '.venv'
      set venv $venv_path[-1]
    else
      set venv $venv_path[-2]
    end

    set -l element (set_color $fish_color_python_venv)
    set -a element "pyv:$venv"
    set -a element (set_color normal)
    set -a context (string join '' $element)
  end

  if set -q RBENV_VERSION; or set version_file (upcate .ruby-version)
    set -q RBENV_VERSION; or read RBENV_VERSION < $version_file

    set -l element (set_color $fish_color_ruby)
    set -a element "rb:$RBENV_VERSION"
    set -a element (set_color normal)
    set -a context (string join '' $element)
  end

  if set -q RUSTUP_TOOLCHAIN; or set toolchain_file (upcate .rust-toolchain)
    set -q RUSTUP_TOOLCHAIN; or read RUSTUP_TOOLCHAIN < $toolchain_file

    set -l element (set_color $fish_color_rust)
    set -a element "rs:$RUSTUP_TOOLCHAIN"
    set -a element (set_color normal)
    set -a context (string join '' $element)
  end

  if string length -q $context
    printf ' [%s]' (echo -n $context)
  end

  __fish_git_prompt

  set job_count (count (jobs))
  if test $job_count -ne 0
    set_color $fish_color_jobs
    printf ' {%i}' $job_count
    set_color normal
  end

  if test $last_status -ne 0
    set_color $fish_color_status
    printf ' [%i]' $last_status
    set_color normal
  end
end
