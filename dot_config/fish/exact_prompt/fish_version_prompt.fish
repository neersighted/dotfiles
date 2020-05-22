function fish_version_prompt
  if set -q GOENV_VERSION; or set version_file (upcate .go-version)
    set -q GOENV_VERSION; or read GOENV_VERSION < $version_file

    set -a contents (string join '' (set_color $fish_color_golang) "go:$GOENV_VERSION" (set_color normal))
  end

  if set -q NODENV_VERSION; or set version_file (upcate .node-version)
    set -q NODENV_VERSION; or read NODENV_VERSION < $version_file

    set -a contents (string join '' (set_color $fish_color_nodejs) "js:$NODENV_VERSION" (set_color normal))
  end

  if set -q PYENV_VERSION; or set version_file (upcate .python-version)
    set -q PYENV_VERSION; or read PYENV_VERSION < $version_file

    set venv_name (string split '/' $VIRTUAL_ENV)[-1]
    if test "$PYENV_VERSION" != "$venv_name"
      set -a contents (string join '' (set_color $fish_color_python) "py:$PYENV_VERSION" (set_color normal))
    end
  end

  if set -q VIRTUAL_ENV; and set venv_path (string split '/' $VIRTUAL_ENV)
    if test $venv_path[-1] != '.venv'
      set venv $venv_path[-1]
    else
      set venv $venv_path[-2]
    end

    set -a contents (string join '' (set_color $fish_color_python_venv) "pyv:$venv" (set_color normal))
  end

  if set -q RBENV_VERSION; or set version_file (upcate .ruby-version)
    set -q RBENV_VERSION; or read RBENV_VERSION < $version_file

    set -a contents (string join '' (set_color $fish_color_ruby) "rb:$RBENV_VERSION" (set_color normal))
  end

  if set -q RUSTUP_TOOLCHAIN; or set toolchain_file (upcate .rust-toolchain)
    set -q RUSTUP_TOOLCHAIN; or read RUSTUP_TOOLCHAIN < $toolchain_file

    set -a contents (string join '' (set_color $fish_color_rust) "rs:$RUSTUP_TOOLCHAIN" (set_color normal))
  end

  if string length -q $contents
    printf ' [%s]' (string join ' ' $contents)
  end
end
