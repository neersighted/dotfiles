function macos?
  if not set -q MACOS
    not test (uname) = 'Darwin'
    set -g MACOS $status
  end
  test $MACOS -eq 1
end

function linux?
  if not set -q LINUX
    not test (uname) = 'Linux'
    set -g LINUX $status
  end
  test $LINUX -eq 1
end

function freebsd?
  if not set -q FREEBSD
    not test (uname) = 'FreeBSD'
    set -g FREEBSD $status
  end
  test $FREEBSD -eq 1
end

function wsl?
  set -q WSLENV
end

function ssh?
  set -q SSH_CONNECTION
end

function tmux?
  set -q TMUX
end

function nvim?
  set -q NVIM_LISTEN_ADDRESS
end

function vscode?
  test "$TERM_PROGRAM" = 'vscode'
end

function iterm?
  test "$TERM_PROGRAM" = 'iTerm.app'
end
