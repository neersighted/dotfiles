# special environment detection
if status --is-login
  # xdg
  if not set -qg XDG_CONFIG_HOME
    set -x XDG_CONFIG_HOME $HOME/.config
  end

  if not set -qg XDG_DATA_HOME
    set -x XDG_DATA_HOME $HOME/.local/share
  end
  if not set -qg XDG_CACHE_HOME
    set -x XDG_CACHE_HOME $HOME/.cache
  end

  # mosh detection
  if test (ps -o comm= (ps -o ppid= %self | string trim -l)) = 'mosh-server'
    set -x MOSH 1
  end

  # wsl detection/fixup
  if set -l uname (string match -r '\d.\d.\d-(\d+)-Microsoft' (uname -r))
    set -x WSL $uname[2]
    set -x DISPLAY ':0'
    set -x SHELL (command -v fish)
  end
end

# interactive features
if status --is-interactive
  # color support detection
  if not set -qg COLORTERM; and not string match -q '(xterm|linux)' $TERM
    set -x COLORTERM 'truecolor'
  end

  # ignore parent exports in favor of universal exports
  for export in (set -Ux)
    set -eg (string split ' ' $export)[1]
  end
end

# universal configuration
if not set -qU fish_initialized
  # linux-specific
  if test (uname) = 'Linux'
    # terminal
    if command -sq alacritty
      set -Ux TERMINAL alacritty
    end

    # browser
    if set -qg WSL
      set -Ux BROWSER wsl-open
    else
      if command -sq firefox
        set -Ux BROWSER firefox
      else if command -sq google-chrome
        set -Ux BROWSER google-chrome
      else
        set -Ux BROWSER lynx
      end
    end

    # libvirt
    set -Ux LIBVIRT_DEFAULT_URI qemu:///system
  end

  # editor
  set -Ux VISUAL nvim
  set -Ux EDITOR $VISUAL

  # pager
  set -Ux PAGER less
  set -Ux MANPAGER 'nvim -c "set ft=man" -'
  set -Ux LESS '--RAW-CONTROL-CHARS' '--tabs=4'

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

  # ruby
  set -Ux RBENV_ROOT $XDG_DATA_HOME/rbenv
  set -Ux GEM_SPEC_CACHE $XDG_CACHE_HOME/gem

  # rust
  set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
  set -Ux CARGO_HOME $XDG_DATA_HOME/cargo
end
