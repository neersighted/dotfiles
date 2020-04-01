function fish_version_prompt
  if set -q GOENV_VERSION; or set version_file (upcate .go-version)
    set -q GOENV_VERSION; or read GOENV_VERSION < $version_file

    set -l element (set_color $fish_color_golang)
    set -a element "go:$GOENV_VERSION"
    set -a element (set_color normal)
    set -a contents (string join '' $element)
  end

  if set -q NODENV_VERSION; or set version_file (upcate .node-version)
    set -q NODENV_VERSION; or read NODENV_VERSION < $version_file

    set -l element (set_color $fish_color_nodejs)
    set -a element "js:$NODENV_VERSION"
    set -a element (set_color normal)
    set -a contents (string join '' $element)
  end

  if set -q PYENV_VERSION; or set version_file (upcate .python-version)
    set -q PYENV_VERSION; or read PYENV_VERSION < $version_file

    set venv_name (string split '/' $VIRTUAL_ENV)[-1]
    if test "$PYENV_VERSION" != "$venv_name"
      set -l element (set_color $fish_color_python)
      set -a element "py:$PYENV_VERSION"
      set -a element (set_color normal)
      set -a contents (string join '' $element)
    end
  end

  if set -q VIRTUAL_ENV; and set venv_path (string split '/' $VIRTUAL_ENV)
    if test $venv_path[-1] != '.venv'
      set venv $venv_path[-1]
    else
      set venv $venv_path[-2]
    end

    set -l element (set_color $fish_color_python_venv)
    set -a element "pyv:$venv"
    set -a element (set_color normal)
    set -a contents (string join '' $element)
  end

  if set -q RBENV_VERSION; or set version_file (upcate .ruby-version)
    set -q RBENV_VERSION; or read RBENV_VERSION < $version_file

    set -l element (set_color $fish_color_ruby)
    set -a element "rb:$RBENV_VERSION"
    set -a element (set_color normal)
    set -a contents (string join '' $element)
  end

  if set -q RUSTUP_TOOLCHAIN; or set toolchain_file (upcate .rust-toolchain)
    set -q RUSTUP_TOOLCHAIN; or read RUSTUP_TOOLCHAIN < $toolchain_file

    set -l element (set_color $fish_color_rust)
    set -a element "rs:$RUSTUP_TOOLCHAIN"
    set -a element (set_color normal)
    set -a contents (string join '' $element)
  end

  if string length -q $contents
    printf ' [%s]' (echo -n $contents)
  end
end
