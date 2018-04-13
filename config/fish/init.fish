# shell init (core environmental variables)
if status --is-login
  # load bass into the path
  set fish_function_path $fish_function_path ~/.config/fish/vendor/functions

  # load system profile
  bass source /etc/profile

  # xdg
  set -q XDG_CONFIG_HOME
    or set -x XDG_CONFIG_HOME $HOME/.config
  set -q XDG_DATA_HOME
    or set -x XDG_DATA_HOME $HOME/.local/share
  set -q XDG_CACHE_HOME
    or set -x XDG_CACHE_HOME $HOME/.cache

  # fresh
  set -x FRESH_BIN_PATH $HOME/.local/bin

  # build our personal path
  path_prepend /usr/local/opt/coreutils/libexec/gnubin # homebrew coreutils
  path_prepend /usr/local/opt/findutils/libexec/gnubin # homebrew findutils
  path_prepend /usr/local/opt/gnu-sed/libexec/gnubin # homebrew sed
  path_prepend /usr/local/opt/gnu-tar/libexec/gnubin # homebrew tar
  path_prepend /usr/local/opt/gnu-getopt/bin # homebrew getopt
  path_prepend /usr/lib/ccache/bin # ccache
  path_prepend ~/.local/bin # fresh/pipsi
  path_prepend ~/.cargo/bin # rustup/cargo
  path_prepend ~/.asdf/bin # asdf (core)
  path_prepend ~/.asdf/shims # asdf (shims)

  # notify systemd of path
  command -s systemctl >/dev/null 2>&1
    and systemctl --user import-environment PATH >/dev/null 2>&1
end

# vi:ft=fish:
