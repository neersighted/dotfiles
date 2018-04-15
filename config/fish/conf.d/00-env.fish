# shell init (core environmental variables)
if status --is-login
  # load system profile (with bass)
  type -q bass
    and bass source /etc/profile

  # xdg
  set -q XDG_CONFIG_HOME
    or set -x XDG_CONFIG_HOME $HOME/.config
  set -q XDG_DATA_HOME
    or set -x XDG_DATA_HOME $HOME/.local/share
  set -q XDG_CACHE_HOME
    or set -x XDG_CACHE_HOME $HOME/.cache

  # xdg (bsd compat)
  type -q vidcontrol >/dev/null;
    and set -x XDG_VTNR (vidcontrol -i active 2>/dev/null)

  # ccache
  path_prepend /usr/local/opt/ccache/libexec # macos
  path_prepend /usr/local/libexec/ccache # bsd
  path_prepend /usr/lib/ccache/bin # linux

  # personal
  path_prepend ~/.local/bin # dotfiles/pipsi
  path_prepend ~/.cargo/bin # rustup/cargo
  path_prepend ~/.asdf/bin # asdf (core)
  path_prepend ~/.asdf/shims # asdf (shims)

  # notify systemd of path
  command -s systemctl >/dev/null 2>&1
    and systemctl --user import-environment PATH >/dev/null 2>&1

  # check for mosh
  set parent (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]'))
  test "$parent" = "mosh-server"
    and set -gx MOSH 1
end

# vi:ft=fish:
