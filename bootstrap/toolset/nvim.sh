# shellcheck shell=sh

toolset_subsection "nvim"

if has_support "Python"; then
  for pair in neovim2:$PYTHON2_VERSION neovim3:$PYTHON3_VERSION; do
    venv=$(echo "$pair" | cut -d: -f1)
    vers=$(echo "$pair" | cut -d: -f2)

    if ! echo "$PYENV_INSTALLED" | grep -Fq "$vers/envs/$venv"; then
      info "Creating $venv ($vers) virtual environment..."
      pyenv uninstall -f "$venv"
      pyenv virtualenv "$vers" "$venv"
      PYENV_VERSION=$venv pip install pynvim
    fi
  done
fi

pipx_install "neovim-remote"
pipx_install "vim-vint"

cargo_install "pack" "https://github.com/maralla/pack"

if [ ! -L "$XDG_CONFIG_HOME/nvim/.pack/packfile" ]; then
  mkdir -p "$XDG_CONFIG_HOME/nvim/.pack"
  ln -s ../packfile "$XDG_CONFIG_HOME/nvim/.pack/packfile"
fi
