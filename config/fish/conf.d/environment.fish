# special environment detection
if status --is-login
  # mosh detection
  if test (ps -o comm= (ps -o ppid:1= %self)) = 'mosh-server'
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
      if type -q firefox-nightly
        set -Ux BROWSER firefox-nightly
      else if type -q firefox
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
  set -Ux CCACHE_DIR "$HOME/.cache/ccache"

  # golang
  set -Ux GOENV_ROOT "$HOME/.local/share/goenv"
  set -Ux GOPATH "$HOME/.local/share/go"

  # node.js
  set -Ux NODENV_ROOT "$HOME/.local/share/nodenv"
  set -Ux NPM_CONFIG_CACHE "$HOME/.cache/npm"

  # python
  set -Ux PYENV_ROOT "$HOME/.local/share/pyenv"
  set -Ux PIPX_HOME "$HOME/.local/share/pipx/venvs"
  set -Ux PIPX_BIN_DIR "$HOME/.local/share/pipx/bin"
  set -Ux PIPENV_SHELL_FANCY 1

  # ruby
  set -Ux RBENV_ROOT "$HOME/.local/share/rbenv"
  set -Ux GEM_SPEC_CACHE "$HOME/.cache/gem"

  # rust
  set -Ux RUSTUP_HOME "$HOME/.local/share/rustup"
  set -Ux CARGO_HOME "$HOME/.local/share/cargo"
end
