# search vendored functions last
set fish_function_path $fish_function_path ~/.config/fish/vendor/functions

# shell init (core environmental variables)
if status --is-login
  # load system profile
  test -f /etc/profile
    and bass source /etc/profile

  # build our personal path
  path_prepend /usr/local/opt/coreutils/libexec/gnubin # homebrew coreutils
  path_prepend /usr/local/opt/findutils/libexec/gnubin # homebrew findutils
  path_prepend /usr/local/opt/gnu-sed/libexec/gnubin # homebrew sed
  path_prepend /usr/local/opt/gnu-tar/libexec/gnubin # homebrew tar
  path_prepend /usr/local/opt/gnu-getopt/bin # homebrew getopt
  path_prepend /usr/lib/ccache/bin # ccache
  path_prepend ~/bin # fresh
  path_prepend ~/.go/bin # go
  path_prepend ~/.cargo/bin # rust
  path_prepend ~/.pyenv/bin # pyenv
  path_prepend ~/.rbenv/bin # rbenv

  # notify systemd of path
  command -s systemctl >/dev/null 2>&1
    and systemctl --user import-environment PATH >/dev/null 2>&1
end

# vi:ft=fish:
