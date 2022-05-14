# prepend an entry to manpath, moving if it already exists
function manup
  for entry in $argv[-1..1]
    set i (contains -i $entry $MANPATH); and set -e MANPATH[$i]
    test -e $entry; and set -p MANPATH $entry
  end
end

# ensure the system manpath is represented
set -q MANPATH; or set -x MANPATH ''

if is_macos
  manup $HOMEBREW_PREFIX/share/man
  set -x INFOPATH $HOMEBREW_PREFIX/share/info ''
end

# nodejs
if set -q NODENV_VERSION; or test -e $NODENV_ROOT/version
  set -q NODENV_VERSION; or read -l NODENV_VERSION < $NODENV_ROOT/version
  manup MANPATH $NODENV_ROOT/versions/$NODENV_VERSION/share/man
end

# python
if set -q PYENV_VERSION; or test -e $PYENV_ROOT/version
  set -q PYENV_VERSION; or read -l PYENV_VERSION < $PYENV_ROOT/version
  manup MANPATH $PYENV_ROOT/versions/$PYENV_VERSION/share/man
end

# ruby
if set -q RBENV_VERSION; or test -e $RBENV_ROOT/version
  set -q RBENV_VERSION; or read -l RBENV_VERSION < $RBENV_ROOT/version
  manup MANPATH $RBENV_ROOT/versions/$RBENV_VERSION/share/man
end

# rust
if test -e $RUSTUP_HOME/toolchains
  set -l rustup_toolchain stable
  if set -q RUSTUP_TOOLCHAIN
    set rustup_toolchain $RUSTUP_TOOLCHAIN
  else if test -e $RUSTUP_HOME/settings.toml
    set rustup_toolchain (string match -r 'default_toolchain = "(.*)"' < $RUSTUP_HOME/settings.toml)[2]
  end
  manup MANPATH $RUSTUP_HOME/toolchains/$rustup_toolchain*/{,share/}man
end

# local
manup MANPATH $HOME/.local/share/man

functions -e manup
