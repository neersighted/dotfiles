if not set -qU fish_initialized;
  # editor
  set -Ux VISUAL nvim
  set -Ux EDITOR $VISUAL

  # pager
  set -Ux PAGER less
  set -Ux MANPAGER 'nvim -c "set ft=man" -'
  set -Ux LESS '--RAW-CONTROL-CHARS --tabs=4'

  # graphical
  set -Ux TERMINAL alacritty
  if test (uname) = "Darwin"
    set -Ux BROWSER open
  else
    if type -q firefox-nightly
      set -Ux BROWSER firefox-nightly
    else if type -q firefox
      set -Ux BROWSER firefox
    else if type -q google-chrome
      set -Ux BROWSER google-chrome
    end
  end

  # libvirt
  set -Ux LIBVIRT_DEFAULT_URI qemu:///system

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
