function fish_command_not_found -a cmd
  printf (_ "fish: Unknown command: %s\n") (string escape -- $cmd) >&2

  if contains -- $cmd -h --help --usage '-?'; or not status is-interactive
    return
  end

  if is_macos
    __fish_command_not_found_macos $cmd
  else if is_linux
    __fish_command_not_found_linux $cmd
  else if is_freebsd
    __fish_command_not_found_freebsd $cmd
  end
end

function __fish_command_not_found_macos -a cmd
  type -q brew; or return
  set -l formulae (brew which-formula $cmd 2>/dev/null)
  test -n "$formulae"; or return
  printf '%s may be installed with:\n' $cmd >&2
  printf '  brew install %s\n' $formulae >&2
end

function __fish_command_not_found_linux -a cmd
  type -q pacman; or return
  set -l pkgs (pacman -Fq /usr/bin/$cmd 2>/dev/null); or return
  printf '%s may be found in the following packages:\n' $cmd >&2
  printf '  %s\n' $pkgs >&2
end

function __fish_command_not_found_freebsd -a cmd
  type -q pkg; or return
  set -l pkgs (pkg provides "local/[s]?bin/$cmd\$" 2>/dev/null)
  test -n "$pkgs"; or return
  printf '%s may be found in the following packages:\n' $cmd >&2
  printf '  %s\n' $pkgs >&2
end
