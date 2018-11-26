# environment fixup
if status --is-login
  # locale
  if not set -qg LANG; or test $LANG = 'C.UTF-8'
    set -gx LANG en_US.UTF-8
  end

  # xdg directories
  if not set -qg XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME $HOME/.config
  end
  if not set -qg XDG_DATA_HOME
    set -gx XDG_DATA_HOME $HOME/.local/share
  end
  if not set -qg XDG_CACHE_HOME
    set -gx XDG_CACHE_HOME $HOME/.cache
  end

  # wsl
  if not set -qg WSL; and set -qg WSLENV
    set -gx WSL (string match -r '^\d.\d.\d-(\d+)-Microsoft$' (uname -r))[2]
    set -gx DISPLAY ':0'
    set -gx SHELL (command -v fish)
    set -gx BROWSER 'powershell.exe Start'
  end
end

# universal configuration
if not set -qU fish_initialized
  # fish
  set -U fish_greeting

  # editor
  set -Ux VISUAL nvim
  set -Ux EDITOR $VISUAL

  # pager
  set -Ux PAGER less
  set -Ux MANPAGER 'nvim -c "set ft=man" -'
  set -Ux LESS '--RAW-CONTROL-CHARS --tabs=4'
  set -Ux LESSHISTFILE $XDG_CACHE_HOME/lesshist

  # gnupg
  set -Ux GNUPGHOME $HOME/.gnupg

  # ccache
  set -Ux CCACHE_DIR $XDG_CACHE_HOME/ccache

  # golang
  set -Ux GOENV_ROOT $XDG_DATA_HOME/goenv
  set -Ux GOPATH $XDG_DATA_HOME/go

  # node.js
  set -Ux NODENV_ROOT $XDG_DATA_HOME/nodenv
  set -Ux NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm

  # python
  set -Ux PYENV_ROOT $XDG_DATA_HOME/pyenv
  set -Ux PIPX_HOME $XDG_DATA_HOME/pipx/venvs
  set -Ux PIPX_BIN_DIR $XDG_DATA_HOME/pipx/bin
  set -Ux PIPENV_SHELL_FANCY 1
  set -Ux PIPENV_VENV_IN_PROJECT 1
  set -Ux PYLINTHOME $XDG_CACHE_HOME/pylint

  # ruby
  set -Ux RBENV_ROOT $XDG_DATA_HOME/rbenv
  set -Ux GEM_SPEC_CACHE $XDG_CACHE_HOME/gem

  # rust
  set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
  set -Ux CARGO_HOME $XDG_DATA_HOME/cargo

  # (n)vim
  set -Ux VIM_CONFIG_PATH $XDG_CONFIG_HOME/nvim

  # libvirt
  set -Ux LIBVIRT_DEFAULT_URI qemu:///system
end

# ignore parent exports in favor of universal exports
for export in (set -Ux)
  set -eg (string split ' ' $export)[1]
end