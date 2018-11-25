# shellcheck shell=sh

toolset_subsection "Neovim"

if ! command -v nvim >/dev/null; then
  if uname | grep -F Linux | grep -Fvq Microsoft && command -v jq >/dev/null; then
    neovim_appimage=$(curl "https://api.github.com/repos/neovim/neovim/releases/latest" \
      | jq -r '.assets[] | select(.name == "nvim.appimage") | .browser_download_url')

    info "Neovim is unavailable! Installing from AppImage..."
    curl -L "$neovim_appimage" -o "$HOME/.local/bin/nvim"
  else
    important "Neovim is unavailable!"
    return
  fi
fi

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

npm_install "neovim"
gem_install "neovim"

pipx_install "neovim-remote"
pipx_install "vim-vint"

cargo_install "pack" "https://github.com/maralla/pack"

if [ ! -L "$XDG_CONFIG_HOME/nvim/.pack" ]; then
  ln -sf packfiles "$XDG_CONFIG_HOME/nvim/.pack"
fi
