# special environment detection
if status --is-login
  # xdg
  if not set -qx XDG_CONFIG_HOME
    set -x XDG_CONFIG_HOME "$HOME/.config"
  end

  if not set -qx XDG_DATA_HOME
    set -x XDG_DATA_HOME "$HOME/.local/share"
  end
  if not set -qx XDG_CACHE_HOME
    set -x XDG_CACHE_HOME "$HOME/.cache"
  end

  # mosh detection
  if test (ps -o comm= (ps -o ppid= %self | tr -d ' ')) = 'mosh-server'
    set -x MOSH 1
  end

  # wsl detection/fixup
  if set -l uname (string match -r '\d.\d.\d-(\d+)-Microsoft' (uname -r))
    set -x WSL $uname[2]
    set -x DISPLAY ':0'
    set -x SHELL (command -v fish)
  end
end

# terminal feature detection
if status --is-interactive
  if not set -qx COLORTERM; and not string match -q '(xterm|linux)' "$TERM"
    set -x COLORTERM 'truecolor'
  end
end

# global configuration
if not set -qU fish_initialized;
  # linux-specific
  if test (uname) = 'Linux'
    # terminal
    if type -q alacritty
      set -Ux TERMINAL alacritty
    end

    # browser
    if set -qx WSL
      set -Ux BROWSER wsl-open
    else
      if type -q firefox
        set -Ux BROWSER firefox
      else if type -q google-chrome
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
  set -Ux LESS '--RAW-CONTROL-CHARS --tabs=4'

  # ccache
  set -Ux CCACHE_DIR "$XDG_CACHE_HOME/ccache"

  # golang
  set -Ux GOENV_ROOT "$XDG_DATA_HOME/goenv"
  set -Ux GOPATH "$XDG_DATA_HOME/go"

  # node.js
  set -Ux NODENV_ROOT "$XDG_DATA_HOME/nodenv"
  set -Ux NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"

  # python
  set -Ux PYENV_ROOT "$XDG_DATA_HOME/pyenv"
  set -Ux PIPX_HOME "$XDG_DATA_HOME/pipx/venvs"
  set -Ux PIPX_BIN_DIR "$XDG_DATA_HOME/pipx/bin"
  set -Ux PIPENV_SHELL_FANCY 1

  # ruby
  set -Ux RBENV_ROOT "$XDG_DATA_HOME/rbenv"
  set -Ux GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem"

  # rust
  set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
  set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
end
